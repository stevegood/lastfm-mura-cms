<cfcomponent extends="BaseAPI">
	<cffunction name="getEvents" access="public" returntype="Struct" output="false">
		<cfargument name="location" type="string" required="true" />
		<cfargument name="distance" type="numeric" required="false" />
		<cfargument name="page" type="numeric" required="false" default="1" />
		
		<cfset var local = {} />
		<cfset local.args = {} />
		<cfset local.args['location'] = arguments.location />
		<cfset local.args['distance'] = arguments.distance />
		<cfset local.args['page'] = arguments.page />
		
		<cfreturn super.callService('geo.getEvents',local.args) />
	</cffunction>
</cfcomponent>