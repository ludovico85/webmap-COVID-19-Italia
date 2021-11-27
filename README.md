# webmap-COVID-19-Italia
Webmap con statistiche sulla diffusione del COVID-19 sul territorio nazionale

<p><a href="https://github.com/ludovico85/webmap-COVID-19-Italia/blob/master/License.txt"><img src="https://camo.githubusercontent.com/b9e61d4d8db6ffad34c4367d2fa7089993491ce7/68747470733a2f2f696d672e736869656c64732e696f2f62616467652f4c6963656e73652d4372656174697665253230436f6d6d6f6e732532304174747269627574696f6e253230342e30253230496e7465726e6174696f6e616c2d626c7565" alt="GitHub license" data-canonical-src="https://img.shields.io/badge/License-Creative%20Commons%20Attribution%204.0%20International-blue" style="max-width:100%;"></a>

![GitHub last commit](https://img.shields.io/github/last-commit/ludovico85/webmap-COVID-19-Italia?color=green&style=plastic)

La webmap, realizzata da <a href="http://www.lezionigis.it" target="_blank">LezioniGIS.it</a> e consultabile all'indirizzo https://ludovico85.github.io/webmap-COVID-19-Italia/,
mostra le mappe e i grafici di diffusione del COVID-19 sul territorio nazionale.
L'intera applicazione è stata sviluppata utilizzando software OpenSource:

- <a href="https://qgis.org/it/site/" target="_blank">QGIS</a> per il trattamento dei dati territoriali
- <a href="https://leafletjs.com/" target="_blank">Leaflet</a> per la creazione della webmap
- <a href="https://www.r-project.org/" target="_blank">R</a> per la creazione dei grafici dinamici e interattivi
  - <a href="https://cran.r-project.org/web/packages/RCurl/index.html" target="_blank">RCurl</a> per lo scaricamento dei dati dal repository
  - <a href="https://cran.r-project.org/web/packages/tidyr/index.html" target="_blank">tidyr</a> e <a href="https://cran.r-project.org/web/packages/reshape2/index.html" target="_blank">Reshape2</a> per la gestione delle tabelle e creazione dei dataframe
  - <a href="https://cran.r-project.org/web/packages/plotly/index.html" target="_blank">plotly</a> e <a href="https://cran.r-project.org/web/packages/ggplot2/index.html" target="_blank">ggplot2</a> per la creazione dei grafici
   - <a href="https://cran.r-project.org/web/packages/rgdal/index.html" target="_blank">rgdal</a> e <a href="https://cran.r-project.org/web/packages/sp/index.html" target="_blank">sp</a> per la manipolazione dei dati geografici e la creazione delle basi dati

I dati utilizzati sono:
- limiti amministrativi ISTAT modificati in QGIS https://www.istat.it/it/archivio/222527
- dati sulla popolazione http://dati.istat.it/Index.aspx?DataSetCode=DCIS_POPRES1#
- dati sulla diffusione del COVID-19 https://github.com/pcm-dpc/COVID-19

Nel REPO sono presenti:
- COVID.R: script di R per la generazione dei grafici e delle mappe
- custom_theme.R: script per la tematizzazione dei grafici
- dati_territoriali.gpkg: GeoPackage contenente i limiti amministrativi e i dati sulla popolazione residente
- webmap: cartella con le librerie e script necessari per la generazione della webmap
- colorbrewer scale.txt: scale di colori utilizzate per tematizzare i layer
____
<b> Modifiche necessarie per aggiornare le mappe e i grafici </b><br>
Per aggiornare i dati giornalieri che compaiono nell'header della sidebar laterale è necessario intervenire sull'<b>index.html</b>. Tramite un editor di testo bisogna incrementare di un'unità il numero tra parentesi quadre; ad esempio il numero 96 si riferisce ai dati del 30 maggio. Per aggiornare al 31 maggio bisogna sostituire il 96 con il 97 e il 95 con il 96.

```
<script type="text/javascript">
$.getJSON('https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json',     function(dati) {
	    	var data = `${dati[96].data})`;
		var text = `Casi totali: ${dati[96].totale_casi}`;
	      	var text2 =`Deceduti: ${dati[96].deceduti}`;
		var text3 =`Guariti: ${dati[96].dimessi_guariti}`;
		var text4 =`Nuovi positivi: ${dati[96].variazione_totale_positivi}`;
		var text1a =` (+${dati[96].totale_casi-dati[95].totale_casi})`;
		var text2a =` (+${dati[96].deceduti-dati[95].deceduti})`;
		var text3a =` (+${dati[96].dimessi_guariti-dati[95].dimessi_guariti})`;console.log(text2);
	      $(".mystat").html(data);
		$(".text1").html(text);
		$(".text2").html(text2);
		$(".text3").html(text3);
		$(".text4").html(text4);
		$(".text1a").html(text1a);
		$(".text2a").html(text2a);
		$(".text3a").html(text3a);
		});
</script>
```


Lo script di R è completamente automatizzato per creare i grafici e gli script javascript per le mappe da utilizzare in leaflet.
Tuttavia è necessario effettuare delle modifiche per aggiornare i grafici e le mappe con i dati giornalieri.


<b> Grafici </b>


L'operazione consiste nell'aggiornare la data ultima per la selezione dei dati (sostituire in tutti i grafici la data di coord_cartesian).
<br>
```
[...]+coord_cartesian(xlim=as.Date(c('2020-02-24','2020-05-30')))+[...]
```
<br>
<b> N.B. </b> Per migliorare la leggibilità dei grafici e in particolare dell'asse X è necessario modificare, ogni volta che si ritiene opportuno, l'intervallo delle etichette dell'asse X. Nello specifico il date_breaks indica l'intervallo temporale delle etichette in asse x.

```[...] labs(x = "data", y = "numero di casi")+scale_x_date(date_breaks = "10 day", [...]```

Nei grafici sono presenti due linee verticali che stanno ad indicare la data d'inizio del lockdown e la data d'inizione della fase 2. Per far apparire correttamente il tooltip bisogna sositutire utilizzando un editor di testo (in seguito ad ogni aggiornamento) all'interno di ogni html (chart0.html, chart1.html e così via) le seguenti stringhe:<br>
```xintercept: 18331</code> con <code>Inizio del lockdown```
```xintercept: 18386</code> con <code>Inizio della Fase 2```

<b> Mappe </b>

Sono necessarie due operazioni.

1) Nello script di R aggiornare il codice <code>regioni_dati<-regioni_dati$`2020-05-30`</code> con la data più recente.

2) Per le mappe l'operazione da fare consiste nel dichiarare, all'inizio dei file javascript contenuti nella cartella dati che costituiscono le mappe, la variabile (utilizzare un editor di testo di Notepd++, Atom, ...).

Esempio di output di R

```
{
"type": "FeatureCollection",
"name": "regioni_geo_casi_totali",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
{ "type": "Feature", "id": 14, "properties": { "DEN_REG": "Molise", "COD_REG": "14", "totale_casi": "17" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ ... ] ] ] } },
]
}
```
Modifica necessaria

```
var nome_variabile =
{
"type": "FeatureCollection",
"name": "regioni_geo_casi_totali",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
{ "type": "Feature", "id": 14, "properties": { "DEN_REG": "Molise", "COD_REG": "14", "totale_casi": "17" }, "geometry": { "type": "MultiPolygon", "coordinates": [ [ [ ... ] ] ] } },
]
}
```
