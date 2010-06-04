<cfcomponent>
	
	<cffunction name="init" access="public" returntype="APIService" output="false">
		<cfargument name="apiKey" type="string" required="true" />
		<cfargument name="secretKey" type="string" required="true" />
		
		<cfset var local = {} />
		<cfset variables['services'] = {} />
		<cfset local.comList = "User" />
		
		<cfloop list="#local.comList#" index="local.com">
			<cfset variables.services[local.com] = CreateObject("component",local.com).init(ArgumentCollection=arguments) />
		</cfloop>
		
		<cfreturn this />
	</cffunction>
	
	<cffunction name="onMissingMethod">
		<cfargument name="missingMethodName" type="string" required="true" />
		<cfargument name="missingMethodArguments" type="struct" required="true" />
		
		<cfset var local = {} />
		<cfset local.result = "" />
		<cfset local.component = listFirst(arguments.missingMethodName,'_') />
		<cfset local.method = listLast(arguments.missingMethodName,'_') />
		
		<cfif StructKeyExists(variables.services,local.component)>
			<cfinvoke component="#variables.services[local.component]#"
					  method="#local.method#"
					  returnvariable="local.result"
					  argumentcollection="#arguments.missingMethodArguments#" />
		</cfif>
		
		<cfreturn local.result />
	</cffunction>
	
</cfcomponent>