<cfcomponent extends="mura.plugin.pluginGenericEventHandler">
	
	<cfset variables.apiKey = "89ec45adf4f345afd4a54de85adc528e" />
	<cfset variables.secretKey = "5fb419de9dd58219d16dbd6dde65a617" />
	
	<cffunction name="onGlobalRequestStart" access="public" returntype="void" output="false">
		<cfargument name="event" />
				
		<cfif NOT StructKeyExists(application,'lastfm') OR cgi.REMOTE_ADDR IS '127.0.0.1'>
			<cfset application.lastfm = CreateObject("component","lastfm.com.lastfm.api.APIService").init(variables.apiKey,variables.secretKey) />
		</cfif>
	</cffunction>
	
	<cffunction name="onSiteRequestStart" access="public" returntype="void" output="false">
		<cfargument name="event" />
		<cfset onGlobalRequestStart(arguments.event) />
	</cffunction>
	
</cfcomponent>