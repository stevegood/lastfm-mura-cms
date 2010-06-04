<cfsilent>
	<cfset api = application.lastfm>
	
	<cfquery name="qGetLastFM" datasource="#application.configbean.getDatasource()#">
		SELECT username,song_count
		FROM lastfm_config
		WHERE siteId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.siteId#" />
	</cfquery>
	
	<cfif qGetLastFM.recordCount>
		<cfset username = qGetLastFM.username />
		<cfset limit = qGetLastFM.song_count />
		<cfset page = 1 />
		<cfset result = api.user_getRecentTracks(username,limit,page) />
	</cfif>
</cfsilent>

<cfif qGetLastFM.recordCount>
	<div class="lastfm">
		<h3>last.fm</h3>
		<cfoutput>
		<cfloop array="#result.recenttracks.track#" index="track">
			<div class="track" id="track_#hash(track.album.mbid & track.artist.mbid & track.name)#">
				<h4><a href="#track.url#" target="_blank">#track.name#</a></h4>
				<img class="albumArt" src="#track.image[1]['##text']#" height="34" width="34" alt="#track.artist['##text']# - #track.album['##text']#" />
				<div class="info">
					<p>Artist: #track.artist['##text']#</p>
					<p>Album: #track.album['##text']#</p>
				</div>
			</div>
		</cfloop>
		</cfoutput>
	</div>
</cfif>