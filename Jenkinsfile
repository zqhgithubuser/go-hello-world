#!groovy

pipeline {
    agent { 
        node { 
            label "slave"
        }
    }

    environment {
        String year = new Date().format("yyyy") 
        String month = new Date().format("MM") 
        String day = new Date().format("dd") 
        String time = new Date().format("HHmmss") 
        image = "zhengqinghong/go-hello-world"
    }

    stages {
        stage('构建镜像') { 
            steps {
                script {
                    try {       
                        env.docker_image = "${image}:main-${year}${month}${day}${time}-${BUILD_ID}"
                        retry(3) {
                            sh """
                            docker run --rm \
                                -v $(pwd):/workspace \
                                -v /root/.docker/config.json:/kaniko/.docker/config.json:ro \
                                gcr.io/kaniko-project/executor:latest \
                                --dockerfile=Dockerfile \
                                --destination=${docker_image} \
                                --cache-copy-layers \
                                --cache=true \
                                --cache-repo=${image} \
                            """
                        }
                    } catch (error) {
                        env.error = sh(returnStdout: true, script: "echo 构建镜像失败: ${error}").trim()
                        echo "error: ${error}"
                        sh "exit 1"
                    }
                }
            }
        }
    }
}
