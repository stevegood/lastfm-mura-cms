<cfcomponent>
	
	<cffunction name="init" access="public" returntype="LastFMService" output="false">
		<cfargument name="siteid" type="string" required="true" />
		<cfset variables.siteid = arguments.siteid />
		<cfreturn this />
	</cffunction>
	
</cfcomponent>