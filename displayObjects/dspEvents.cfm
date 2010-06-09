<cfsilent>
	<cfset api = application.lastfm>
	
	<cfquery name="qGetLastFM" datasource="#application.configbean.getDatasource()#">
		SELECT location,distance,tagList
		FROM lastfm_config
		WHERE siteId = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#session.siteId#" />
	</cfquery>
	
	<cfif qGetLastFM.recordCount>
		<cfset location = qGetLastFM.location />
		<cfset distance = qGetLastFM.distance />
		<cfset page = 1 />
		<cfset tagList = qGetLastFM.tagList />
		<cfset result = api.geo_getEvents(location,distance,page) />
	</cfif>
</cfsilent>

<div class="lastfm">
	<h3>last.fm - Events <br />Concerts in <cfoutput>#location#</cfoutput></h3>
	<cfoutput>
		<cfloop array="#result.events.event#" index="theEvent">
			<cfsilent>
				
				<cfset albumArt = "#$.getConfigBean().getAssetPath()#/plugins/#pluginConfig.getDirectory()#/images/missing-album-art.png" />
				<cfif len(theEvent.image[1]['##text'])>
					<cfset albumArt = theEvent.image[1]['##text'] />
				</cfif>
				
				<cfif ListLen(tagList)>
					<cfset showEvent = 0 />
					<cfif StructKeyExists(theEvent, "tags")>
						<cfif isArray(theEvent.tags.tag)>
							<cfloop array="#theEvent.tags.tag#" index="theTag">
								<cfif ListFindNoCase(tagList,theTag,",")>
									<cfset showEvent = 1>
									<cfbreak>
								</cfif>
							</cfloop>
						<cfelse>
							<cfif ListFindNoCase(tagList,theEvent.tags.tag,",")>
								<cfset showEvent = 1>
							</cfif>
						</cfif>
					</cfif>
				</cfif>
				
			</cfsilent>
			<cfif NOT ListLen(tagList) OR showEvent EQ 1>
				<div class="track" id="event_#hash(theEvent.id)#">
					<h4><a href="#theEvent.url#" target="_blank">#theEvent.title#</a></h4>
					<img class="albumArt" src="#albumArt#" height="34" width="34" alt="#theEvent.title#" />
					<div class="info">
						<p>Location: #theEvent.venue.name#</p>
						<p>Date: #DateFormat(theEvent.startDate, "mm/dd/yyyy")#</p>
						<p>Time: #TimeFormat(theEvent.startDate, "hh:mm tt")#</p>
					</div>
				</div>
			</cfif>
		</cfloop>
	</cfoutput>
</div>