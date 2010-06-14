<cfcomponent>
	
	<cffunction name="init" returntype="any" access="public" output="false">
		<cfargument name="config"  type="any" default="">
		
		<cfset variables.config = arguments.config />
		<cfset variables.datasource = variables.config.getConfigBean().getDatasource() />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="install" returntype="void" access="public" output="false">
		<cfswitch expression="#variables.config.getConfigBean().getDBType()#">
			<cfcase value="mysql">
				<cfset installMySQL() />
			</cfcase>
			
			<cfcase value="mssql">
				<cfset installMSSQL() />
			</cfcase>
		</cfswitch>
	</cffunction>
	
	<cffunction name="update" returntype="void" access="public" output="false">
	</cffunction>
	
	<cffunction name="delete" returntype="void" access="public" output="false">
	</cffunction>
	
	<cffunction name="installMySQL" access="private" output="false" returntype="void">
		<cfquery datasource="#variables.datasource#">
		CREATE  TABLE IF NOT EXISTS `lastfm_config` (
		`siteid` VARCHAR(255) NOT NULL ,
		`song_count` INT NOT NULL DEFAULT 10 ,
		`username` VARCHAR(255) NULL ,
		`location` VARCHAR(255) NOT NULL ,
		`distance` INT NULL ,
		`tagList` VARCHAR(255) NULL ,
		PRIMARY KEY (`siteid`) );
		</cfquery>
	</cffunction>
	
	<cffunction name="installMSSQL" access="private" output="false" returntype="void">
		
	</cffunction>
	
</cfcomponent>