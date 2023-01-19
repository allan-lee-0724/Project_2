pipeline{
    agent{
        kubernetes{
            inheritFrom "devops"
        }
    }

    environment{
        DEVOPS_REGISTRY='teamkuberknights/planetarium:rollingV4'
        DEVOPS_IMAGE=''
    }

    stages{
        stage("build and push docker image"){
            steps{
                container("docker"){
                    script{
                        DEVOPS_IMAGE=docker.build(DEVOPS_REGISTRY, ".")
                        docker.withRegistry("", 'docker-creds'){
                            DEVOPS_IMAGE.push("$currentBuild.number")
                        }
                    }
                }
            }
        }
    }
}

