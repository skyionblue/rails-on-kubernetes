namespace :docker do
  desc "Push docker images to DockerHub"
  task :push_image do
    TAG = `git rev-parse --short HEAD`.strip

    puts "Building Docker image"
    sh "docker build -t tigersquad/k8s-rails-app:#{TAG} ."

    IMAGE_ID = `docker images | grep tigersquad\/k8s-rails-app | head -n1 | awk '{print $3}'`.strip

    puts "Tagging latest image"
    sh "docker tag #{IMAGE_ID} tigersquad/k8s-rails-app:latest"

    puts "Pushing Docker image"
    sh "docker push tigersquad/k8s-rails-app:#{TAG}"
    sh "docker push tigersquad/k8s-rails-app:latest"

    puts "Done"
  end

end
