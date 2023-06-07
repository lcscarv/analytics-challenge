version_line=$(cat dbt_project.yml | grep ^version)
version=$(echo $version_line | grep -o -P "(?<=').*(?=')")
bumped_version=$(echo ${version} | awk -F. '{print $1"."$2"."$3+1}')

sed -i "s/^version:.*/version: '$bumped_version'/g" dbt_project.yml

git add dbt_project.yml
git commit -m "[skip CI]"
git push
git tag -m 'Bumped version through bitbucket pipelines' $bumped_version
git push origin $bumped_version

git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git remote update
git fetch --all
git checkout develop
git merge master
git commit -m "[skip CI]"
git push origin develop
