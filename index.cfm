<cfinclude template="plugin/config.cfm" />

<cfsilent>
	<cfset qResult = StructNew() />
	<cfset qResult.username = "" /> 
	<cfset qResult.song_count = "" />
	
	<cfquery name="qGetLastFM" datasource="#application.configbean.getDatasource()#">
		SELECT username,song_count
		FROM lastfm_config
		WHERE siteId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.siteId#" />  
	</cfquery>
	
	<cfif qGetLastFM.recordCount>
		<cfset qResult.username = qGetLastFM.username />
		<cfset qResult.song_count = qGetLastFM.song_count />
	</cfif>
		 
	<cfif StructKeyExists(form,"submit")>
		<cfif qGetLastFM.recordCount>
			<cfquery name="qUpdate" datasource="#application.configbean.getDatasource()#">
				UPDATE lastfm_config
				SET username = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.username#" />,
					song_count = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.song_count#" />
				WHERE siteId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.siteId#" />
			</cfquery>
		<cfelse>
			<cfquery name="qUpdate" datasource="#application.configbean.getDatasource()#">
				INSERT INTO lastfm_config(username,song_count,siteid)
				VALUES(<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#form.username#" />,<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#form.song_count#" />,<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.siteId#" />)
			</cfquery>	
		</cfif>
		<cfset qResult.username = form.username />
		<cfset qResult.song_count = form.song_count />
	</cfif>
</cfsilent> 

<cfsavecontent variable="variables.body">
	<cfoutput>
		<h2>#request.pluginConfig.getName()#</h2>
		<div>
			<form name"lastfm" action="index.cfm" method="post" onsubmit="return validate(this);">
				<ul>
					<li>
						<label for="username">Username</label><input type="text" id="username" name="username" value="#qResult.username#" required="true" message="Please enter a username." />
					</li>
					<li>
						<label for="song_count">Song Count</label><input type="text" id="song_count" name="song_count" value="#qResult.song_count#" required="true" message="Please enter a song count." validate="numeric" />
					</li>
				</ul>
				<div class="buttons">
					<input type="submit" name="submit" value="publish" />
				</div>
			</form>	
		</div> 	
	</cfoutput> 	 	
</cfsavecontent>

<cfoutput>#application.pluginManager.renderAdminTemplate(body=variables.body,pageTitle=request.pluginConfig.getName())#</cfoutput>
