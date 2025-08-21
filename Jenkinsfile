pipeline {
    agent any 
	
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
	    APP_NAME = "register-app-pipeline"
            RELEASE = "1.0.0"
            DOCKER_USER = "prajnashetty529"
            DOCKER_PASS = 'dckr_pat_stE2kIRzItpGYsn_KhVWNbjqLjg'
            IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
            IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
	    JENKINS_API_TOKEN = "11bac6e646775b4a53d219fd04b4a95c0d"
    }
    stages{
        stage("Cleanup Workspace"){
                steps {
                cleanWs()
                }
        }

        stage("Checkout from SCM"){
                steps {
                    git branch: 'main', credentialsId: 'github', url: 'https://github.com/Ashfaque-9x/register-app'
                }
        }

        stage("Build Application"){
            steps {
                sh "mvn clean package"
            }

       }

       stage("Test Application"){
           steps {
                 sh "mvn test"
           }
       }

       stage("SonarQube Analysis") {
		   steps {
		        script {
		            sh '''
		                mvn sonar:sonar \
		                -Dsonar.projectKey=Register-App \
		                -Dsonar.host.url=http://20.55.91.91:9000 \
		                -Dsonar.login=sqa_715d546d39bf07acbfeade31eacb5422d734ee81
		            '''
		        }
		    }
	   }

       

        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }
       }

       stage("Trivy Scan") {
           steps {
               script {
	            sh ('docker run -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image ashfaque9x/register-app-pipeline:latest --no-progress --scanners vuln  --exit-code 0 --severity HIGH,CRITICAL --format table')
               }
           }
       }

       stage ('Cleanup Artifacts') {
           steps {
               script {
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
               }
          }
       }
	}

    post {
    failure {
        // Existing email notification
        emailext body: '''${SCRIPT, template="groovy-html.template"}''', 
                 subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Failed", 
                 mimeType: 'text/html',to: "varshithag@devtools.in"
 
        // Create GitHub Issue
        script {
            withCredentials([string(credentialsId: 'GitHub', variable: 'GITHUB_TOKEN')]) {
                def repoOwner = 'Varshitha-DevTools'   
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
        emailext body: '''${SCRIPT, template="groovy-html.template"}''', 
                 subject: "${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} - Successful", 
                 mimeType: 'text/html',to: "varshithag@devtools.in"
    }
}
