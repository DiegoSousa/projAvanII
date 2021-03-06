<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="parte1" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">
	<!--Author: Diego Sousa - diego@diegosousa.com-->
	<head>
		<regionBase>
			<!-- Obs: É Possivel criar apenas uma region para ser usada por
			rIconeInteratividade, rTempGRU, rTempPOA e rTempJPA já que possem
			a mesma localização, mas por organização adicionei uma para cada.  -->
			<region id="rVideoPrincipal" width="100%" height="100%" zIndex="1"/>
			<region id="rIconeInteratividade" right="5%" top="1%" width="200" height="230" zIndex="2"/>
			<region id="rTempGRU" right="1%" top="10%" width="200" height="230" zIndex="2"/>
			<region id="rTempPOA" right="1%" top="10%" width="200" height="230" zIndex="2"/>
			<region id="rTempJPA" right="1%" top="10%" width="200" height="230" zIndex="2"/>
		</regionBase>
		
		<descriptorBase>
			<descriptor id="dVideoPrincipal" region="rVideoPrincipal"/>
			<descriptor id="dIconeInteratividade" region="rIconeInteratividade"/>			
			<descriptor id="dTempGRU" region="rTempGRU" explicitDur="5s">
				<descriptorParam name="fontSize" value="45"/>
			</descriptor>
			<descriptor id="dTempPOA" region="rTempPOA" explicitDur="5s">
				<descriptorParam name="fontSize" value="45"/>
			</descriptor>
			<descriptor id="dTempJPA" region="rTempJPA" explicitDur="5s">
				<descriptorParam name="fontSize" value="45"/>
			</descriptor>
		</descriptorBase>
		
		<connectorBase>
			<causalConnector id="onBeginStart_vDelay">
				<connectorParam name="vDelay"/>
				<simpleCondition role="onBegin"/>
				<simpleAction role="start" delay="$vDelay" max="unbounded" qualifier="par"/>
			</causalConnector>
			<causalConnector id="onBeginStop_vDelay">
				<connectorParam name="vDelay"/>
				<simpleCondition role="onBegin"/>
				<simpleAction role="stop" delay="$vDelay" max="unbounded" qualifier="par"/>
			</causalConnector>
			<causalConnector id="onEndStart">
				<simpleCondition role="onEnd"/>
				<simpleAction role="start"/>
			</causalConnector>
			<causalConnector id="onEndAbort">
				<simpleCondition role="onEnd"/>
				<simpleAction role="abort"/>
			</causalConnector>			
		</connectorBase>
	</head>
	<body>
		<port id="pVideoPrincipal" component="mVideoPrincipal"/>
		
		<media id="mVideoPrincipal" src="../media/Movie.mp4" descriptor="dVideoPrincipal"/>
		<media id="mIconeInteratividade" src="../media/interactive.png" descriptor="dIconeInteratividade"/>		
		<media id="mTempGRU" src="../media/TempGRU.txt" descriptor="dTempGRU"/>
		<media id="mTempPOA" src="../media/TempPOA.txt" descriptor="dTempPOA"/>
		<media id="mTempJPA" src="../media/TempJPA.txt" descriptor="dTempJPA"/>
		
		<link id="lVideoPrincipal" xconnector="onBeginStart_vDelay">
			<linkParam name="vDelay" value="5s"/>
			<bind role="onBegin" component="mVideoPrincipal"/>
			<bind role="start" component="mIconeInteratividade"/>
		</link>
		<link id="lVideoPrincipalTwo" xconnector="onBeginStop_vDelay">
			<linkParam name="vDelay" value="10s"/>
			<bind role="onBegin" component="mVideoPrincipal"/>
			<bind role="stop" component="mIconeInteratividade"/>
		</link>		
		<link id="lGRU" xconnector="onEndStart">
			<bind role="onEnd" component="mIconeInteratividade"/>
			<bind role="start" component="mTempGRU"/>
		</link>		
		<link id="lPOA" xconnector="onEndStart">
			<bind role="onEnd" component="mTempGRU"/>
			<bind role="start" component="mTempPOA"/>
		</link>
		<link id="lJPA" xconnector="onEndStart">
			<bind role="onEnd" component="mTempPOA"/>
			<bind role="start" component="mTempJPA"/>
		</link>
		<link id="lInteracaoPause" xconnector="onEndStart">
			<bind role="onEnd" component="mTempJPA"/>
			<bind role="start" component="mIconeInteratividade"/>
		</link>
		<link id="lTheEnd" xconnector="onEndAbort">
			<bind role="onEnd" component="mVideoPrincipal"/>
			<bind role="abort" component="mIconeInteratividade"/>
		</link>
	</body>
</ncl>
