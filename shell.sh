#!/usr/bin/env bash
# Executing the following via 'ssh ec2-user@www.boyishwei.com -i /Users/Ryan/aws/boyishwei.pem -o StrictHostKeyChecking=no -t':
#
#!/usr/bin/env bash

# Go to the deploy path
cd "/home/ec2-user/blog" || (
echo "! ERROR: not set up."
echo "The path '/home/ec2-user/blog' is not accessible on the server."
echo "You may need to run 'mina setup' first."
false
) || exit 15

# Check releases path
if [ ! -d "releases" ]; then
echo "! ERROR: not set up."
echo "The directory 'releases' does not exist on the server."
echo "You may need to run 'mina setup' first."
exit 16
fi

# Check lockfile
if [ -e "deploy.lock" ]; then
echo "! ERROR: another deployment is ongoing."
echo "The file 'deploy.lock' was found."
echo "If no other deployment is ongoing, run 'mina deploy:force_unlock' to delete the file."
exit 17
fi

# Determine $previous_path and other variables
[ -h "current" ] && [ -d "current" ] && previous_path=$(cd "current" >/dev/null && pwd -LP)
build_path="./tmp/build-`date +%s`$RANDOM"
version=$((`cat "/home/ec2-user/blog/last_version" 2>/dev/null`+1))
release_path="releases/$version"

# Sanity check
if [ -e "$build_path" ]; then
echo "! ERROR: Path already exists."
exit 18
fi

# Bootstrap script (in deployer)
(
echo "-----> Creating a temporary build path"
touch "deploy.lock" &&
mkdir -p "$build_path" &&
cd "$build_path" &&
(
  (
  
    if [ ! -d "/home/ec2-user/blog/scm/objects" ]; then
      echo "-----> Cloning the Git repository"
      git clone "git@github.com:boyishwei/boyishwei-jekyll.git" "/home/ec2-user/blog/scm" --bare
    else
      echo "-----> Fetching new git commits"
      (cd "/home/ec2-user/blog/scm" && git fetch "git@github.com:boyishwei/boyishwei-jekyll.git" "master:master" --force)
    fi &&
    echo "-----> Using git branch 'master'" &&
    git clone "/home/ec2-user/blog/scm" . --recursive --branch "master" &&
          
          echo "-----> Using this git commit" &&
          echo &&
          git rev-parse HEAD > .mina_git_revision &&
          git --no-pager log --format='%aN (%h):%n> %s' -n 1 &&
          rm -rf .git &&
          echo
  
  ) && (
  
    echo "-----> Installing gem dependencies using Bundler"
    mkdir -p "/home/ec2-user/blog/shared/bundle"
    mkdir -p "./vendor"
    ln -s "/home/ec2-user/blog/shared/bundle" "./vendor/bundle"
    bundle install --without development:test --path "./vendor/bundle" --deployment
  
  ) && (
  
    jekyll build
  
  )
) &&
echo "-----> Deploy finished"
) &&

#
# Build
(
echo "-----> Building"
echo "-----> Moving build to $release_path"
mv "$build_path" "$release_path" &&
cd "$release_path" &&
(
  true
) &&
echo "-----> Build finished"

) &&

#
# Launching
# Rename to the real release path, then symlink 'current'
(
echo "-----> Launching"
echo "-----> Updating the current symlink" &&
ln -nfs "$release_path" "current"
) &&

# ============================
# === Start up serve => (in deployer)
(
echo "-----> Launching"
cd "$release_path"
true
) &&

# ============================
# === Complete & unlock
(
rm -f "deploy.lock"
echo "$version" > "./last_version"
echo "-----> Done. Deployed v$version"
) ||

# ============================
# === Failed deployment
(
echo "! ERROR: Deploy failed."



echo "-----> Cleaning up build"
[ -e "$build_path" ] && (
  rm -rf "$build_path"
)
[ -e "$release_path" ] && (
  echo "Deleting release"
  rm -rf "$release_path"
)
(
  echo "Unlinking current"
  [ -n "$previous_path" ] && ln -nfs "$previous_path" "current"
)

# Unlock
rm -f "deploy.lock"
echo "OK"
exit 19
)
       Elapsed time: 0.00 seconds
