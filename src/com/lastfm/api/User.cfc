<cfcomponent extends="BaseAPI">
	
	<cffunction name="getRecentTracks" access="public" returntype="Struct" output="false">
		<cfargument name="user" type="string" required="true" />
		<cfargument name="limit" type="numeric" required="false" default="10" />
		<cfargument name="page" type="numeric" required="false" default="1" />
		
		<cfset var local = {} />
		<cfset local.args = {} />
		<cfset local.args['limit'] = arguments.limit />
		<cfset local.args['page'] = arguments.page />
		<cfset local.args['user'] = arguments.user />
		
		<cfreturn super.callService('user.getRecentTracks',local.args) />
	</cffunction>
	
</cfcomponent>