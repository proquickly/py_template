job("Build and push Docker") {
    host("Build artifacts and a Docker image") {
        // generate artifacts required for the image
        shellScript {
            content =
               ./generateArtifacts.sh
          }

        dockerBuildPush {
        
            context = ""
            file = "Dockerfile"
            labels["vendor"] = "pqoquickly"
            // args["HTTP_PROXY"] = "http://10.20.30.1:123"

            val spaceRepo = "proqickly.registry.jetbrains.space/p/py_template/py_template"
            // image tags for 'docker push'
            tags {
                +"$spaceRepo:1.0.${"$"}JB_SPACE_EXECUTION_NUMBER"
                +"$spaceRepo:latest"
            }
        }
    }
}