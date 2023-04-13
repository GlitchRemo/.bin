#! /bin/bash

function scaffolding() {
  PROJECT_NAME=$1

  # setting up repository
  mkdir -p $PROJECT_NAME/src $PROJECT_NAME/lib $PROJECT_NAME/test
  cd $PROJECT_NAME

  # setting up all files
  cp ~/workspace/js/.lib/testing.js lib/
  cp ~/workspace/js/.lib/return_one.js src/$PROJECT_NAME.js
  cp ~/workspace/js/.lib/test_prototype.js test/${PROJECT_NAME}-test.js

  # correcting variable names
  sed -i "" -e "s/projectName/${PROJECT_NAME}/g" test/${PROJECT_NAME}-test.js
  SOURCE_OBJECT_NAME=$(echo ${PROJECT_NAME} | gsed "s/-\(.\)/\U\1/g")
  sed -i "" -e "s/source/${SOURCE_OBJECT_NAME}/g" test/${PROJECT_NAME}-test.js

  # building runtest.sh
  echo -e "#! /bin/bash \nnode test/${PROJECT_NAME}-test.js" > runtest.sh
  chmod +x runtest.sh

  # setting up .gitignore file to ignore .swp files
  echo "*.swp" > .gitignore

  # git init
  git init
  git add .
  git status

  # launching us to project repository
  # cd $PROJECT_NAME
}

scaffolding $1
