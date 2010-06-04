<cfsilent>
	<cfset api = application.lastfm />
	<cfset username = "stevegood" />
	<cfset limit = 10 />
	<cfset page = 1 />
	<cfset result = api.user_getRecentTracks(username,limit,page) />
</cfsilent>

<style>
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
</style>

<div class="lastfm">
	<h3>last.fm</h3>
	<cfoutput>
	<cfloop array="#result.recentTracks.track#" index="track">
		<cfset albumArt = "#$.getConfigBean().getAssetPath()#/plugins/#pluginConfig.getDirectory()#/images/missing-album-art.png" />
		<cfif len(track.image[1]['##text'])>
			<cfset albumArt = track.image[1]['##text'] />
		</cfif>
		<div class="track" id="track_#hash(track.album.mbid & track.artist.mbid & track.name)#">
			<h4><a href="#track.url#" target="_blank">#track.name#</a></h4>
			<img class="albumArt" src="#albumArt#" height="34" width="34" alt="#track.artist['##text']# - #track.album['##text']#" />
			<div class="info">
				<p>Artist: #track.artist['##text']#</p>
				<p>Album: #track.album['##text']#</p>
			</div>
		</div>
	</cfloop>
	</cfoutput>
</div>