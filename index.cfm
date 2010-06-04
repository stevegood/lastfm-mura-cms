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
	
	<h2>Usage</h2>
	<p>By design no styles are applied to the generated output.  Below is sample CSS that can be used to style the plugin's output.</p>
	<pre>
.lastfm {width:156px;}
.lastfm h3 {font-size:1.25em;}
.lastfm .track {
	margin: 0 0 10px 0;
	clear:both;
}
.lastfm .track h4 {font-size:1em;}
.lastfm .track .albumArt {
	float:left;
	margin:0 3px 0 0;
}
.lastfm .track .info {
	min-height:34px;
	vertical-align:middle;
	margin:0;
}
.lastfm .track .info p {
	margin:0;
	font-size:.80em;
}
	</pre>
	<p>Below is a sample of the genterated output.</p>
	<pre>
&lt;div class="lastfm"&gt;
	&lt;h3&gt;last.fm&lt;/h3&gt;
		
	&lt;div class="track" id="track_C8A4C1FECB2D117058EDC6AAA177C07B"&gt;
		&lt;h4&gt;&lt;a href="http://www.last.fm/music/Rebecca+St.+James/_/Breathe" target="_blank"&gt;Breathe&lt;/a&gt;&lt;/h4&gt;
		&lt;img class="albumArt" src="http://userserve-ak.last.fm/serve/34s/13890569.jpg" height="34" width="34" alt="Rebecca St. James - worship GOD" /&gt;
		&lt;div class="info"&gt;

			&lt;p&gt;Artist: Rebecca St. James&lt;/p&gt;
			&lt;p&gt;Album: worship GOD&lt;/p&gt;
		&lt;/div&gt;
	&lt;/div&gt;
		
	&lt;div class="track" id="track_FD6A9F7EC5DEB1A6D73CCAB45F9D1151"&gt;
		&lt;h4&gt;&lt;a href="http://www.last.fm/music/Steven+Curtis+Chapman/_/I+Will+Be+Here" target="_blank"&gt;I Will Be Here&lt;/a&gt;&lt;/h4&gt;
		&lt;img class="albumArt" src="http://userserve-ak.last.fm/serve/34s/13961865.jpg" height="34" width="34" alt="Steven Curtis Chapman - All About Love" /&gt;
		&lt;div class="info"&gt;
			&lt;p&gt;Artist: Steven Curtis Chapman&lt;/p&gt;
			&lt;p&gt;Album: All About Love&lt;/p&gt;
		&lt;/div&gt;
	&lt;/div&gt;
	
	&lt;div class="track" id="track_ED8E2B944D00B5838F8BC35560D74C0F"&gt;
		&lt;h4&gt;&lt;a href="http://www.last.fm/music/Jeremy+Camp/_/Take+You+Back" target="_blank"&gt;Take You Back&lt;/a&gt;&lt;/h4&gt;
		&lt;img class="albumArt" src="http://images.amazon.com/images/P/B00068CV9E.01.MZZZZZZZ.jpg" height="34" width="34" alt="Jeremy Camp - Restored" /&gt;
		&lt;div class="info"&gt;
			&lt;p&gt;Artist: Jeremy Camp&lt;/p&gt;
			&lt;p&gt;Album: Restored&lt;/p&gt;
		&lt;/div&gt;
	&lt;/div&gt;
&lt;/div&gt;
	</pre>
</cfsavecontent>

<cfoutput>#application.pluginManager.renderAdminTemplate(body=variables.body,pageTitle=request.pluginConfig.getName())#</cfoutput>
