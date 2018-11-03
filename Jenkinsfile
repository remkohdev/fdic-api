node {
    
    stage("Checkout SCM") {
        checkout scm: [
          $class: 'GitSCM', 
          userRemoteConfigs: [[url: "https://github.com/remkohdev/fdic-api.git", credentialsId: "github.api.token"]], 
          branches: [[name: '*/master']]
        ], 
        changelog: false, 
        poll: false;
    }
    
    stage('Postman Tests'){
      env.POSTMAN_COLLECTION='postman/FDIC-API.postman_collection.json'
      env.POSTMAN_ENVIRONMENT='postman/FDIC-API_LOCALHOST.postman_environment.json'
    
      withEnv(["PATH+NODE=${tool name: 'NodeJS 10.13.0', type: 'jenkins.plugins.nodejs.tools.NodeJSInstallation'}/bin"]) {
        sh """
          node -v
          #npm install -g newman
          newman run ${env.POSTMAN_COLLECTION} -e ${env.POSTMAN_ENVIRONMENT} --timeout-request 5000
        """
      }
    }

}
