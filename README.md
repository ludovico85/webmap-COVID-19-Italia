# webmap-COVID-19-Italia
Webmap con statistiche sulla diffusione del COVID-19 sul territorio nazionale

<img src="https://www.lezionigis.it/wp-content/uploads/2020/03/Cattura.png" height="100%" width="100%">

La webmap, realizzata da <a href="http://www.lezionigis.it" target="_blank">LezioniGIS.it</a> e consultabile all'indirizzo https://www.lezionigis.it/mappa-di-diffusione-del-covid-19-sul-territorio-italiano/
mostra le mappe e i grafici di diffusione del COVID-19 sul territorio nazionale.
L'intera applicazione è stata sviluppata utilizzando sowftware OpenSource:

- <a href="https://qgis.org/it/site/" target="_blank">QGIS</a> per il trattamento dei dati territoriali
- <a href="https://leafletjs.com/" target="_blank">Leaflet</a> per la creazione della webmap
- <a href="https://www.r-project.org/" target="_blank">R</a> per la creazione dei grafici dinamici e interattivi

I dati utilizzati sono:
- limiti amministrativi ISTAT modificati in QGIS https://www.istat.it/it/archivio/222527
- dati sulla diffusione del COVID-19 https://github.com/pcm-dpc/COVID-19

Nel REPO sono presenti:
COVID.R: script di R per la generazione dei grafici e delle mappe
custom_theme.R: script per la tematizzazione dei grafici
regioni.gpkg: GeopAckage contenente i limiti amministrativi
webmap: cartella con le librerie e script necessari per la generazione della webmap

Lo script di R è completamente automatizzato per creare i grafici e gli script javascrip per le mappe da utilizzare in leaflet. L'unica operazione da fare consiste nel dichiarare all'inizio dei file javascript contenuti nella cartella dati che costituiscono le mappe la variabile.
Esempio di output di R

<code>
{
"type": "FeatureCollection",
"name": "regioni_geo_casi_totali",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
{ "type": "Feature", "id": 14, "properties": { "DEN_REG": "Molise", "COD_REG": "14", "totale_casi": "17" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ ... ] ] ] } },
]
}
</code>

Modifica necessaria

<code>
var nome_variabile = 
{
"type": "FeatureCollection",
"name": "regioni_geo_casi_totali",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
{ "type": "Feature", "id": 14, "properties": { "DEN_REG": "Molise", "COD_REG": "14", "totale_casi": "17" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ ... ] ] ] } },
]
}
</code>

<p><a href="https://github.com/ludovico85/webmap-COVID-19-italia/blob/master/license"><img src="https://camo.githubusercontent.com/b9e61d4d8db6ffad34c4367d2fa7089993491ce7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c6963656e73652d4372656174697665253230436f6d6d6f6e732532304174747269627574696f6e253230342e30253230496e7465726e6174696f6e616c2d626c7565" alt="GitHub license" data-canonical-src="https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue" style="max-width:100%;"></a>
<a href="https://github.com/ludovico85/webmap-COVID-19-italia/commits/master"><img src="https://camo.githubusercontent.com/f5f7431cfccb2ebed2649bb2e2ab87ddc4659461/68747470733a2f2f696d672e736869656c64732e696f2f6769746875622f6c6173742d636f6d6d69742f70636d2d6470632f434f5649442d3139" alt="GitHub commit" data-canonical-src="https://img.shields.io/github/last-commit/pcm-dpc/COVID-19" style="max-width:100%;"></a></p>

