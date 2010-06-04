<cfinclude template="plugin/config.cfm" />

<cfsilent> 
	
</cfsilent> 

<cfsavecontent variable="variables.body">
<cfoutput>

<h2>#request.pluginConfig.getName()#</h2>

</cfoutput>	
</cfsavecontent>

<cfoutput>#application.pluginManager.renderAdminTemplate(body=variables.body,pageTitle=request.pluginConfig.getName())#</cfoutput>