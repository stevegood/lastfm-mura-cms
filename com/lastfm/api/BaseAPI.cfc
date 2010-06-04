<cfcomponent>
	
	<cffunction name="init" access="public" returntype="BaseAPI" output="false">	
		<cfargument name="apiKey" type="string" required="true" />
		<cfargument name="secretKey" type="string" required="true" />
		
		<cfset variables.apiKey = arguments.apiKey />
		<cfset variables.secretKey = arguments.secretKey />
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="callService" access="private" output="false" returntype="any">
		<cfargument name="method" type="string" required="true" />
		<cfargument name="args" type="struct" required="false" default="#StructNew()#" />
		
		<cfset var local = {} />
		<cfset local.queryString = "?format=json&method=#arguments.method#&api_key=#variables.apiKey#" />
		
		<cfloop list="#StructKeyList(arguments.args)#" index="local.arg">
			<cfset local.queryString = local.queryString & '&#local.arg#=#arguments.args[local.arg]#' />
		</cfloop>
		
		<cfhttp url="http://ws.audioscrobbler.com/2.0/#local.queryString#" result="local.lastResult" method="get">
		</cfhttp>
		
		<cfreturn deserializeJSON(local.lastResult.fileContent) />
	</cffunction>
	
</cfcomponent>