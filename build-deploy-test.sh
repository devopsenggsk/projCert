version=`grep version package.json | cut -d"\"" -f 4`
echo "version="$version
filecount=`ls -a | grep .version | wc -l`
if [ $filecount == 0 ]
then
  echo "0.0.0" > .version
fi
pre_version=`cat .version`
echo "pre_version="$pre_version


if [ $pre_version != $version ]
then
  sudo docker build -t phpwebsite:$version .

  sudo docker stop phpwebsite
  sudo docker rm phpwebsite

  sudo docker run --name phpwebsite -p 9090:80 -d --restart=unless-stopped phpwebsite:$version

fi

echo $version > .version
