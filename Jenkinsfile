pipeline {
    agent any
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }

    environment {
        APP_NAME = "register-app-pipeline"
        RELEASE = "1.0.0"
        DOCKER_CREDENTIALS = credentials("dockerhub-creds")
        IMAGE_NAME = "${DOCKER_CREDENTIALS_USR}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }

    stages {
        stage("Cleanup Workspace") {
            steps {
                cleanWs()
            }
        }

        stage("Checkout from SCM") {
            steps {
                git branch: 'main', credentialsId: 'Org', url: 'https://github.com/Varshitha-DevTools/register-app.git'
            }
        }

        stage('java version') {
            steps {
                sh 'java -version'
            }
        }

        stage("Build Application") {
            steps {
                sh '''
                    mvn clean
                    mvn package
                '''
            }
        }

        stage("Verify Compilation") {
            steps {
                sh '''
                    echo "Listing compiled class files in target/classes:"
                    find target/classes -name "*.class" || echo "No .class files found!"
                '''
            }
        }

        stage("SonarCloud Scan") {
            steps {
                withCredentials([string(credentialsId: 'sonarcloud-token2', variable: 'SONAR_TOKEN')]) {
                    sh '''
                        sonar-scanner \
                            -Dsonar.projectKey=varshitha-devtools_jenkins-pipeline \
                            -Dsonar.organization=varshitha-devtools \
                            -Dsonar.token=${SONAR_TOKEN} \
                            -Dsonar.sources=. \
                            -Dsonar.java.binaries=target/classes \
                            -Dsonar.host.url=https://sonarcloud.io
                    '''
                }
            }
        }


        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub-creds') {
                        docker_image = docker.build("${IMAGE_NAME}")
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push("latest")
                    }
                }
            }
        }

        stage("Trivy Scan") {
            steps {
                script {
                    sh """
                        docker run -v /var/run/docker.sock:/var/run/docker.sock \
                        aquasec/trivy image ${IMAGE_NAME}:${IMAGE_TAG} \
                        --no-progress --scanners vuln --exit-code 0 --severity HIGH,CRITICAL --format table
                    """
                }
            }
        }


        stage("Run Application for DAST") {
            steps {
                script {
                    sh """
                        docker run -d -p 8080:8080 --name test-app ${IMAGE_NAME}:${IMAGE_TAG}
                        sleep 10  # give it time to start
                    """
                }
            }
        }

        // DAST security scan using ZAP
        stage("DAST - Security Scan") {
            steps {
                script {
                    def target = "http://localhost:8080"
                    sh """
                        docker run -v /var/run/docker.sock:/var/run/docker.sock --network host \\
                            owasp/zap2docker-stable zap-baseline.py -t ${target} -r zap-report.html
                    """
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'zap-report.html', fingerprint: true
                    sh "docker rm -f test-app || true"
                }
            }
        }

        stage("Cleanup Artifacts") {
            steps {
                script {
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG} || true"
                    sh "docker rmi ${IMAGE_NAME}:latest || true"
                }
            }
        }

        // Uncomment and fix when needed
        // stage("Trigger CD Pipeline") {
        //     steps {
        //         script {
        //             withCredentials([string(credentialsId: 'JENKINS_API_TOKEN', variable: 'API_TOKEN')]) {
        //                 sh """
        //                     curl -v -k --user admin:${API_TOKEN} -X POST \
        //                     -H 'cache-control: no-cache' \
        //                     -H 'content-type: application/x-www-form-urlencoded' \
        //                     --data 'IMAGE_TAG=${IMAGE_TAG}' \
        //                     http://48.214.144.64:8080/job/Deployment/buildWithParameters?token=Org
        //                 """
        //             }
        //         }
        //     }
        // }
    }

    post {
        failure {
            emailext(
                body: '''${SCRIPT, template="groovy-html.template"}''',
                subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Failed",
                mimeType: 'text/html',
                to: "botuser.1411@gmail.com"
            )

            script {
                withCredentials([string(credentialsId: 'GitHub', variable: 'GITHUB_TOKEN')]) {
                    def repoOwner = 'Samarth-DevTools'
                    def repoName = 'register-app'
                    def issueTitle = "Jenkins Build Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER}"
                    def issueBody = """\
                    Build URL: ${env.BUILD_URL}
                    Job: ${env.JOB_NAME}
                    Build Number: ${env.BUILD_NUMBER}
                    Result: FAILURE
                    Please check the Jenkins console output for details.
                    """.stripIndent()

                    def jsonPayload = groovy.json.JsonOutput.toJson([
                        title: issueTitle,
                        body: issueBody
                    ])

                    sh """
                        curl -s -H "Authorization: token ${GITHUB_TOKEN}" \
                            -H "Accept: application/vnd.github.v3+json" \
                            -X POST \
                            -d '${jsonPayload}' \
                            https://api.github.com/repos/${repoOwner}/${repoName}/issues
                    """
                }
            }
        }

        success {
            emailext(
                body: '''${SCRIPT, template="groovy-html.template"}''',
                subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Successful",
                mimeType: 'text/html',
                to: "botuser.1411@gmail.com"
            )
        }
    }
}
