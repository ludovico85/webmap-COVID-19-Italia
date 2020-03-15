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

