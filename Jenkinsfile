#!groovy​

node {
    try {
        stage('Checkout Source') {
            checkout scm
        }

        stage('Build Sourcemod plugins') {
            sh 'docker pull crinis/builder-sourcemod'
            def sourcemod = docker.image('crinis/builder-sourcemod')
            sourcemod.pull()
            sourcemod.inside('--user root') {
                sh 'cp -R disable-logging-in-warmup.sp /home/builder/sourcemod/addons/sourcemod/scripting/'
                sh 'bash /home/builder/sourcemod/addons/sourcemod/scripting/compile.sh disable-logging-in-warmup.sp'
                sh 'mkdir -p build/addons/sourcemod/plugins/ build/addons/sourcemod/scripting/'
                sh 'mv /home/builder/sourcemod/addons/sourcemod/scripting/compiled/disable-logging-in-warmup.smx build/addons/sourcemod/plugins/'
                sh 'cp disable-logging-in-warmup.sp build/addons/sourcemod/scripting/'
                sh 'chown --reference ./ -R build/'
            }
        }

        stage('Compress build artifacts') {
            sh "mv build/ disable-logging-in-warmup-${BUILD_ID}/"
            sh "tar -czf disable-logging-in-warmup-${BUILD_ID}.tar.gz disable-logging-in-warmup-${BUILD_ID}/"
        }

        stage('Archive build artifacts') {
            archiveArtifacts "disable-logging-in-warmup-${BUILD_ID}.tar.gz"
        }

        stage('Cleanup workspace') {
            deleteDir()
        }

    } catch (Exception e) {
        throw e;
    } finally {

    }
}