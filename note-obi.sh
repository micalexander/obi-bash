#!/bin/sh

#functions
salts()  {
perl -i -pe '
  BEGIN {
    $keysalts = qx(curl -sS https://api.wordpress.org/secret-key/1.1/salt)
  }
  s/\/\/ Insert_Salts_Below/$keysalts/g
' wp-config.php

}
sql_credentials()  {
	host=`awk -F\' -v H_PATTERN="$H_PATTERN" '$0 ~ H_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	user=`awk -F\' -v U_PATTERN="$U_PATTERN" '$0 ~ U_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	pass=`awk -F\' -v P_PATTERN="$P_PATTERN" '$0 ~ P_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	db=`awk -F\' -v N_PATTERN="$N_PATTERN" '$0 ~ N_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	url=`awk -F\' -v URL_PATTERN="$URL_PATTERN" '$0 ~ N_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
}
f_sql_credentials()  {
	f_host=`awk -F\' -v F_H_PATTERN="$F_H_PATTERN" '$0 ~ F_H_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	f_user=`awk -F\' -v F_U_PATTERN="$F_U_PATTERN" '$0 ~ F_U_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	f_pass=`awk -F\' -v F_P_PATTERN="$F_P_PATTERN" '$0 ~ F_P_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	f_db=`awk -F\' -v F_N_PATTERN="$F_N_PATTERN" '$0 ~ F_N_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	find=`awk -F\' -v F_URL_PATTERN="$F_URL_PATTERN" '$0 ~ F_URL_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
}
r_sql_credentials()  {
	r_host=`awk -F\' -v R_H_PATTERN="$R_H_PATTERN" '$0 ~ R_H_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	r_user=`awk -F\' -v R_U_PATTERN="$R_U_PATTERN" '$0 ~ R_U_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	r_pass=`awk -F\' -v R_P_PATTERN="$R_P_PATTERN" '$0 ~ R_P_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	r_db=`awk -F\' -v R_N_PATTERN="$R_N_PATTERN" '$0 ~ R_N_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
	replace=`awk -F\' -v R_URL_PATTERN="$R_URL_PATTERN" '$0 ~ R_N_PATTERN {print $4}' "$PROJ/site/wp-config.php"`
}


# Store the type of project to create
ACTION=$1

# Store the name of the new project which will double as the project folder name
PROJ_FOLDER_NAME=$2

case $ACTION in
	setup )
		if [ ! -d "$PROJ_FOLDER_NAME" ]
		then
			clear
			echo ""
			echo "\t\t\t""Please enter a valid path"
			echo ""
			echo "\t\t\t""Usage: [new] then [setup] then [path-to-projects]"
			echo ""

		elif [ -z "$PROJ_FOLDER_NAME" ]
		then
			clear
			echo ""
			echo "\t\t\t""Please enter the path of your projects folder"
			echo ""
			echo "\t\t\t""Usage: [new] then [setup] then [path-to-projects]"
			echo ""
		else
			clear
			cd ~
			echo "$PROJ_FOLDER_NAME/" > .obiconfig
			echo ""
			echo "\t\t\t""Your path to your projects folder has ben set to"
			echo ""
			echo "\t\t\t"`cat ~/.obiconfig`
			echo ""
			echo "\t\t\t""To change this simply run setup again"
			echo ""
		fi ;;
	* )
		# If third parameter (project path) is left empty,
		case $3 in
			lts|ltp|stl|stp|ptl|pts) PROJ_PATH=`cat ~/.obiconfig`
				;;
				* )
					if [ -z "$3" ]

					# Then use the default project folder
					then
						PROJ_PATH=`cat ~/.obiconfig`
					else

						# Else store the given directory as the project folder as the third variable
						PROJ_PATH=$3/
					fi
		esac

		# Store the project path and the project name as a single string
		PROJ=$PROJ_PATH$PROJ_FOLDER_NAME

		# Check to see if a name was give to store as the project name
		# if  [ -z "$PROJ_FOLDER_NAME" ]
		# then
		# 	clear
		# 	echo ""
		# 	echo "\t\t\t""You didn't enter a desired project folder name"
		# 	echo ""
		# 	echo "\t\t\t""Usage: [new] then a flag [-w for wordpress git repo] or [-g for empty git repo]"
		# 	echo "\t\t\t\tthen [project_name]"
		# 	echo ""
		elif [ ! -f ~/.obiconfig ] || [ ! -s ~/.obiconfig ]
		then
			clear
			echo ""
			echo "\t\t\t""You don't seem to have a .obiconfig file configured"
			echo ""
			echo "\t\t\t""please run [new] [setup] [path-to-projects]"
			echo "\t\t\t\t""then try again"
			echo ""

		# Check to see if the directory given is writable and a flag was given for the project type
		elif [  -d "$PROJ" ] && [ "$3" != "lts" ] && [ "$3" != "ltp" ] && [ "$3" != "stl" ] && [ "$3" != "stp" ] && [ "$3" != "ptl" ] && [ "$3" != "pts" ] && [ "$1" != "-d" ]
		then
			echo "project exist"
		elif [ ! -d "$PROJ_PATH" -a -w "$PROJ_PATH" ]
		then
			echo "not a directory or not writable"
		elif [ ! -z "$ACTION"  ]
		then
			case $ACTION in
				-f )
					clear
					cd "$PROJ_PATH"
					mkdir $PROJ_FOLDER_NAME
					cd $PROJ_FOLDER_NAME
					mkdir -p architecture/estimates architecture assets/ai assets/content assets/images/gif assets/images/jpg assets/images/png assets/images assets/pdf assets/psd assets dumps/local dumps/production dumps/staging dumps emails fonts mock-ups site
					ls -laO
					echo "Project Location:" `pwd` ;;
				-g )
					clear
					cd "$PROJ_PATH"
					mkdir $PROJ_FOLDER_NAME
					cd $PROJ_FOLDER_NAME
					mkdir -p architecture/estimates architecture assets/ai assets/content assets/images/gif assets/images/jpg assets/images/png assets/images assets/pdf assets/psd assets dumps/local dumps/production dumps/staging dumps emails fonts mock-ups site
					cd site
					git init
					git remote add beanstalk git@psstudios.beanstalkapp.com:/$PROJ_FOLDER_NAME.git
					git config branch.master.remote beanstalk
					echo ".DS_Store\nwp-config.php" > .gitignore
					ls -laO
					echo "Project Location:" `pwd` ;;
				-w )
					clear
		            cd "$PROJ_PATH"
		            mkdir $PROJ_FOLDER_NAME
		            cd $PROJ_FOLDER_NAME
		            mkdir -p architecture/estimates architecture assets/ai assets/content assets/images/gif assets/images/jpg assets/images/png assets/images assets/pdf assets/psd assets dumps/local dumps/production dumps/staging dumps emails fonts mock-ups site
		            cd site
		            git init
		            git remote add beanstalk git@psstudios.beanstalkapp.com:/$PROJ_FOLDER_NAME.git
		            # Get latest version of wordpress
		            wget http://wordpress.org/latest.zip
		            tar --strip-components=1 -zxvf latest.zip
		            rm latest.zip
		            # Clean up stock wordpress themes/plugins
					rm -Rf wp-content/themes/twentyeleven/
					rm -Rf wp-content/themes/twentytwelve/
					rm -Rf wp-content/plugins/akismet/
					rm wp-content/plugins/hello.php
					rm wp-config-sample.php
		            # Get latest version of klas starter theme
		            git clone https://github.com/kylelarkin/klas.git wp-content/themes/$PROJ_FOLDER_NAME
		            rm -Rf wp-content/themes/$PROJ_FOLDER_NAME/.git
		            rm wp-content/themes/$PROJ_FOLDER_NAME/.gitignore
		            mv wp-content/themes/$PROJ_FOLDER_NAME/.htaccess .
		            mv wp-content/themes/$PROJ_FOLDER_NAME/wp-config.php .
		            # Setup local database values in wp-config.php
		            user=`awk -F\' '/local_db_user/ {print $4}' "wp-config.php"`
		            name="$PROJ_FOLDER_NAME"_local_db
		            pass=`awk -F\' '/local_db_password/ {print $4}' "wp-config.php"`
		            host=`ifconfig | grep -Eo 192.168.[0-9]+.[0-9]+ | head -n 1`
		            grep -rl replace_with_local_db wp-config.php | xargs sed -i.bak "s/replace_with_local_db/${name}/g"
		            grep -rl replace_with_local_ip wp-config.php | xargs sed -i.bak "s/replace_with_local_ip/${host}/g"
		            grep -rl wp_ wp-config.php | xargs sed -i.bak "s/wp_/${PROJ_FOLDER_NAME}_/"
		            grep -rl \".dev\" wp-config.php | xargs sed -i.bak "s/\".dev\"/\"http:\/\/${PROJ_FOLDER_NAME}.dev\"/"
					# add stalts
				    salts
				    # clean up
		            rm wp-config.php.bak
					# Build project's .gitignore
		            echo ".DS_Store \n.sass-cache/\nwp-config.php" > .gitignore
		            # Create project's databse
		            /Applications/MAMP/Library/bin/mysql -u $user -h localhost -p$pass -Bse "CREATE DATABASE ${name};"
		            ls -laO
		            echo "Project Location:" `pwd` ;;
	             -d)
					if [ -z $PROJ_FOLDER_NAME ] || [ ! -d "$PROJ_FOLDERPATH" ]
				    then
				    	echo ""
				    	echo "Please provide a project name."
				    	echo "Usage: "
				    	exit 0
				    elif [ ! -z $3 ] && [ $3 == "-l" ]
				    then
				        H_PATTERN=local_db_host
				        U_PATTERN=local_db_user
				        P_PATTERN=local_db_password
				        N_PATTERN=local_db_name
				        URL_PATTERN=local_site_url

				    elif [ ! -z $3 ] && [ $3 == "-s" ]
				    then
				        H_PATTERN=staging_db_host
				        U_PATTERN=staging_db_user
				        P_PATTERN=staging_db_password
				        N_PATTERN=staging_db_name
				        URL_PATTERN=staging_site_url

				    elif [ ! -z $3 ] && [ $3 == "-p" ]
				    then
				        H_PATTERN=prod_db_host
				    	U_PATTERN=prod_db_user
				        P_PATTERN=prod_db_password
				        N_PATTERN=prod_db_name
				        URL_PATTERN=prod_site_url
				    else
				        echo ""
				        echo "Please provide a an option:"
				        echo "Enter -l for local or -p for production."
				        echo ""
				        exit 0
				    fi

				    #looks for database username, database password and database name in the wp-config file
					sql_credentials

				    d="$(date +%A-%m-%d-%Y)"
				    t=$db
				    the_file_name=$t-$d
				    /Applications/MAMP/Library/bin/mysqldump --net_buffer_length=50000 -h$host -u$user -p$pass $db > $PROJ_PATH$PROJ_FOLDER_NAME/dumps/$the_file_name.sql

				    echo ""
				    echo "Database dump successful"
				    echo ""
				    ;;
			 	 -s)
			        case $3 in
			            lts )
			                #staging information used to import
			                F_H_PATTERN=staging_db_host
			                F_U_PATTERN=staging_db_user
			                F_P_PATTERN=staging_db_password
			                F_N_PATTERN=staging_db_name

			                #find prod url to find and replace prod url throughout the db
			                F_URL_PATTERN=local_site_url

							#mysql credentials used to find
							f_sql_credentials

			                #local information used to dump
			                R_H_PATTERN=local_db_host
			                R_U_PATTERN=local_db_user
			                R_P_PATTERN=local_db_password
			                R_N_PATTERN=local_db_name

			                #local url to replace prod url throughout the db
			                R_URL_PATTERN=staging_site_url

							#mysql credentials used to replace
							r_sql_credentials
			                ;;
			            ltp )
			                #prod information used to import
			                F_H_PATTERN=prod_db_host
			                F_U_PATTERN=prod_db_user
			                F_P_PATTERN=prod_db_password
			                F_N_PATTERN=prod_db_name

			                #find local url to find and replace local url throughout the db
			                F_URL_PATTERN=local_site_url

							#mysql credentials used to find
							f_sql_credentials

			                R_H_PATTERN=local_db_host
			                R_U_PATTERN=local_db_user
			                R_P_PATTERN=local_db_password
			                R_N_PATTERN=local_db_name

			                #prod url to replace local url throughout the db
			                R_URL_PATTERN=prod_site_url

							#mysql credentials used to replace
							r_sql_credentials

			                ;;
			            stl )
			                #local information used to import
			                F_H_PATTERN=local_db_host
			                F_U_PATTERN=local_db_user
			                F_P_PATTERN=local_db_password
			                F_N_PATTERN=local_db_name

			                #find staging url to find and replace staging url throughout the db
			                F_URL_PATTERN=staging_site_url

							#mysql credentials used to find
							f_sql_credentials

			                #staging information used to dump
			                R_H_PATTERN=staging_db_host
			                R_U_PATTERN=staging_db_user
			                R_P_PATTERN=staging_db_password
			                R_N_PATTERN=staging_db_name

			                #local url to replace prod url throughout the db
			                R_URL_PATTERN=local_site_url

							#mysql credentials used to replace
							r_sql_credentials
			                ;;
			            stp )
			                #prod information used to import
			                F_H_PATTERN=prod_db_host
			                F_U_PATTERN=prod_db_user
			                F_P_PATTERN=prod_db_password
			                F_N_PATTERN=prod_db_name

			                #find staging url to find and replace staging url throughout the db
			                F_URL_PATTERN=staging_site_url

							#mysql credentials used to find
							f_sql_credentials

			                #staging information used to dump
			                R_H_PATTERN=staging_db_host
			                R_U_PATTERN=staging_db_user
			                R_P_PATTERN=staging_db_password
			                R_N_PATTERN=staging_db_name

			                #prod url to replace prod url throughout the db
			                R_URL_PATTERN=prod_site_url

							#mysql credentials used to replace
							r_sql_credentials
			                ;;
			            ptl )
			                #local information used to import
			                F_H_PATTERN=local_db_host
			                F_U_PATTERN=local_db_user
			                F_P_PATTERN=local_db_password
			                F_N_PATTERN=local_db_name

			                #find prod url to find and replace prod url throughout the db
			                F_URL_PATTERN=prod_site_url

							#mysql credentials used to find
							f_sql_credentials

			                #prod information used to dump
			                R_H_PATTERN=prod_db_host
			                R_U_PATTERN=prod_db_user
			                R_P_PATTERN=prod_db_password
			                R_N_PATTERN=prod_db_name

			                #local url to replace prod url throughout the db
			                R_URL_PATTERN=local_site_url

							#mysql credentials used to replace
							r_sql_credentials
			                ;;
			            pts )
			                #staging information used to import
			                F_H_PATTERN=staging_db_host
			                F_U_PATTERN=staging_db_user
			                F_P_PATTERN=staging_db_password
			                F_N_PATTERN=staging_db_name

			                #find prod url to find and replace prod url throughout the db
			                F_URL_PATTERN=prod_site_url

							#mysql credentials used to find
							f_sql_credentials

			                #prod information used to dump
			                R_H_PATTERN=prod_db_host
			                R_U_PATTERN=prod_db_user
			                R_P_PATTERN=prod_db_password
			                R_N_PATTERN=prod_db_name

			                #staging url to replace prod url throughout the db
			                R_URL_PATTERN=staging_site_url

							#mysql credentials used to replace
							r_sql_credentials
			                ;;
			                *) echo "empty"
			        esac

			        d="$(date +%A-%m-%d-%Y)"
			        t=$f_db
			        the_file_name=$t-$d

			        /Applications/MAMP/Library/bin/mysqldump --net_buffer_length=50000 -h$r_host -u$r_user -p$r_pass $r_db > $PROJ_PATH$PROJ_FOLDER_NAME/dumps/$the_file_name.sql
			        sed -i '' 's,$find,$replace,g' "$PROJ_PATH$PROJ_FOLDER_NAME/dumps/$the_file_name.sql"
			        /Applications/MAMP/Library/bin/mysql -h$f_host -u$f_user -p$f_pass $f_db < $PROJ_PATH$PROJ_FOLDER_NAME/dumps/$the_file_name.sql
			        ;;
				 * )
					clear
					echo ""
					echo "\t\t\t""Unrecognized syntax"
					echo ""
					echo "\t\t\t""Usage: new [-w for wordpress] or [-g for empty git repo] then [project_name]"
					echo ""
			esac


		else
				clear
				echo ""
				echo "\t\t" "Looks like the project name [ $PROJ_FOLDER_NAME ] already exist in this directory "
				echo ""
				echo "\t\t" "[ $PROJ_PATH ]"
				echo ""


		fi
esac