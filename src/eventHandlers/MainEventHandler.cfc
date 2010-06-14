<cfcomponent extends="mura.plugin.pluginGenericEventHandler">
	
	<!--- these are specific to the plugin as an application --->
	<cfset variables.apiKey = "89ec45adf4f345afd4a54de85adc528e" />
	<cfset variables.secretKey = "5fb419de9dd58219d16dbd6dde65a617" />
	
	<cffunction name="onGlobalRequestStart" access="public" returntype="void" output="false">
		<cfargument name="event" />
		
		<cfset var local = {} />
		
		<!--- init the last.cfm api proxy --->
		<cfif NOT StructKeyExists(application,'lastfm') OR cgi.REMOTE_ADDR IS '127.0.0.1'>
			<cfset application.lastfm = {} />
			<cfset application.lastfm.api = CreateObject("component","lastfm.com.lastfm.api.APIService").init(variables.apiKey,variables.secretKey) />
		</cfif>
		
		<cfif NOT StructKeyExists(application.lastfm,session.siteid)>
			<cfquery datasource="#application.configBean.getDatasource()#" name="local.qSettings">
			SELECT * FROM lastfm_config WHERE siteId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.siteId#" />
			</cfquery>
			
			<cfset application.lastfm[session.siteid] = {} />
			<cfloop list="#local.qSettings.ColumnList#" index="local.column">
				<cfset application.lastfm[session.siteid][local.column] = local.qSettings[local.column] />
			</cfloop>
		</cfif>
	</cffunction>
	
	<cffunction name="onSiteRequestStart" access="public" returntype="void" output="false">
		<cfargument name="event" />
		<!--- call onGlobalRequestStart() to ensure that object creation happens no matter where the plugin is called (front end | admin) --->
		<cfset onGlobalRequestStart(arguments.event) />
	</cffunction>
	
</cfcomponent>