{% extends "collection.tpl" %}
{% block html_head_extra %}
<style>
#toggle_btn {
   float: right;
}
a#toggle_btn:hover {
   color: #0778B0;
   text-decoration: none;
   border-bottom: 0px;
}
.pad_left_20 {
   padding-left: 20px;
}

.condensed {
   line-height: 1em;
}
.label,
.badge {
  display: inline-block;
  padding: 2px 4px;
  font-size: 11.844px;
  font-weight: bold;
  line-height: 14px;
  color: #ffffff;
  text-shadow: 0 -1px 0 rgba(0, 0, 0, 0.25);
  white-space: nowrap;
  vertical-align: baseline;
  background-color: #999999;
}

.label {
  -webkit-border-radius: 3px;
     -moz-border-radius: 3px;
          border-radius: 3px;
}

.label:empty,
.badge:empty {
  display: none;
}

.label-info,
.badge-info {
  background-color: #3a87ad;
}

img.spotlight {
  border: solid #eee 8px;
  border-radius: 8px;
}
</style>
{% endblock %}

{% block content %}
        <article id="content">
                <div class="padding">
                        <h1>{{ m.rsc[id].title }}</h1>
                        {% if m.rsc[id].summary %}<p class="summary">{{ m.rsc[id].summary }}</p>{% endif %}
                        {{ m.rsc[id].body }}
                </div>
        </article>
        {% if m.rsc[id].o.haspart|first %}
	<div id="panel">
		{% include "_zotonic_sites_2_col.tpl" %}
	</div>
        {% else %}
	<div id="panel">
		<h2>Coming Soon!</h2>	
	</div>
        {% endif %}

{% endblock %}
