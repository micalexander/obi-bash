# Obi

Obi is a all-in-one tool designed to make project management, WordPress development, MySQL database backups and syncing MySQL databases between multi-environments a breeze.

## Installation:

If you haven't already, create a folder named "bin" and a file named ".bash_profile" with the following text on it `export PATH=$HOME/bin:$PATH`, and place them **separately** in your home directory root folder. Assuming you already have Git installed run this command from your terminal:

`cd $HOME/bin/ ; git clone https://github.com/micalexander/obi.git`

Run:

`obi config`

Enter your setting and thats it.

## Useage:

`obi` `[argument]`

or

`obi` `[argument]` `[project_name]` `[environment(s)]`

### Arguments:

`config`: configure obi

`help`: prints usage to the terminal

`mysql`: login mysql database  *(Followed by the `[environment(s)]`)*

`kill`: Remove a working directory completely *(Followed by the `[project_name]`)*

`-e`: Create an empty working directory *(Followed by the `[project_name]`)*

`-g`: Create a git repository working directory *(Followed by the `[project_name]`)*

`-w`: Create a WordPress enabled git working directory *(Followed by the `[project_name]`)*

`-b`: Backup mysql database *(Followed by the `[project_name]` and then the `[environment(s)]`)*

### Project name:

`[project_name]` : Name of the directory that contains your project.

### Environments:

`-l`: local

`-s`: staging

`-p`: production

`-lts`: local to staging

`-ltp`: local to production

`-stl`: staging to local

`-stp`: staging to production

`-ptl`: production to local

`-pts`: production to staging

## Configuration

When the command `obi`... is ran for the first time, a single hidden file is instantly generated in your home directory with the name .obiconfig. **Please do not edit this file directly.** This file is used by obi to store the path to your local projects directory that contains all of your projects along with your multiple environment settings.

**To edit this file** simply run the command `obi config`.

The default settings are as follows:

	localprojectdirectory='0'
	localsettings='enabled'
	localhost='localhost'
	localuser='root'
	localpassword='root'

	stagingsettings='disabled'
	stagingdomain='0'
	staginghost='0'
	staginguser='0'
	stagingpassword='0'

	productionsettings='disabled'
	productiondomain='0'
	productionhost='0'
	productionuser='0'
	productionpassword='0'


By default when this file is created it the `localprojectdirectory` is not set and before obi can be used, it needs to be set to your local projects directory as a direct path without the trailing slash. The `localsettings` by default are set to enabled and the `stagingsettings` and `productionsetttings` to disabled.

The `localsettings`, `stagingsettings` and `productionsetttings` control how obi will access your MySQL credentials. The three possible settings are:

	enabled
	wp-enabled
	disabled

`enabled`: obi will use the credentials that are set below it.

`wp-enabled`: obi will use the credentials that are on the [wp-config.php](https://github.com/kylelarkin/klas/blob/master/wp-config.php)  file.

`disabled`: obi will not use any credentials

## Working Directory

The directory structure below is automatically generated when using the `-e`, `-g` or `-w` arguments, followed by the `project-name`. This way it is very easy to stay organized.

There are two directories that are essential to obi's functionality. These directories are the dumps and site directories. The dumps directory is used when backing up MySQL databases with the argument `-b`, followed by the `project-name` and then the `[environment(s)]`. Which is then placed its environment folder respectively. The site directory is where WordPress is installed when using the argument `-w` followed by the `project-name`.

project-name
    |
    |--_obi
        |
        |-- architecture
        |    |-- estimates
        |
        |-- assets
        |    |-- ai
        |    |-- content
        |    |-- fonts
        |    |-- images
        |    |   |-- gif
        |    |   |-- jpg
        |    |   |-- png
        |    |
        |    |-- pdf
        |    |-- psd
        |
        |-- dumps
        |    |-- local
        |    |-- production
        |    |-- staging
        |    |-- temp
        |
        |-- emails
    |
    site-root


## Database Backups

With Obi there are two ways to back up a MySQL database. One is just a straight backup to a .sql file that is automatically placed in its respected folder in the dumps directory. The second is a backup to a .sql file (placed in its respected folder) and then imported it into another MySQL database. The latter of the two will not only dump the destination MySQL database to it's respected folder first (as an added precaution), but will also perform a find and replace on the URLs that are stored in the .sql file before it's imported to it's destination database.

By default Obi looks in the [wp-config.php](https://github.com/kylelarkin/klas/blob/master/wp-config.php) for the URLs to find and replace

## wp-config.php

Obi relies on a special [wp-config.php](https://github.com/kylelarkin/klas/blob/master/wp-config.php) file to perform it's find and replace function and any other of its MySQL tasks. This file is included in the [KLAS Wordpress Theme Framework](https://github.com/kylelarkin/klas) when running the `-w` argument.

When the `-w` argument is used to create a WordPress enabled git working directory, the `project_name` that is entered is also used in the [wp-config.php](https://github.com/kylelarkin/klas/blob/master/wp-config.php) and throughout the [KLAS Wordpress Theme Framework](https://github.com/kylelarkin/klas), changing the theme name from its default of klas to the  `project name` you entered as well as in other places that are necessary. Obi will also use this to change the table_prefix from wp_ to the first three letters of the `project_name`.

Obi will set the staging_tld (used to detect if Wordpress is on the staging server) to what ever the `stagingdomain` in the .obiconfig file is set to.

Salts are also added to the [wp-config.php](https://github.com/kylelarkin/klas/blob/master/wp-config.php) file automatically.


## Examples:

`obi -e myproject`: This tells Obi to create an empty working directory named myproject.

`obi -b -ltp`: This tells Obi to make a backup of local and import it into the production database.

### Dependencies

- Git (duh!)
- Uses the [KLAS Wordpress Theme Framework](https://github.com/kylelarkin/klas) - A SASS based starter theme for WordPress.
