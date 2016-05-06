{% extends "base.tpl" %}

{% block title %}{{ m.rsc[id].seo_title | default: m.rsc[id].title }}{% endblock %}

{% block page_class %}home{% endblock %}

{% block banner %}

	<section id="banner">
		<section id="download-zotonic">
			<a href="/download" title="">
                <img src="/lib/images/download_zotonic.png" alt="" />
                <span class="header">Download Zotonic</span>
                <span class="subheader">Release {{ m.config.site.current_release.value }}</span>
            </a>
		</section>
		<section id="docs-zotonic">
			<a href="/docs" title=""><img src="/lib/images/docs.png" alt="" />
                <span class="header">Zotonic documentation</span>
                <span class="subheader">{_ Read about getting up to speed fast _}</span>
            </a>
		</section>
	</section>

{% endblock %}

{% block content %}

	<article id="content" class="zp-67">
		<div class="padding">

			<h1>{{ m.rsc[id].title }}</h1>
			{{ m.rsc[id].body|show_media }}

		</div>
	</article>

{% endblock %}

{% block sidebar %}
	
	<aside id="sidebar" class="zp-33">
		<h2>Open Source</h2>
		<p>Zotonic is released under the Open Source <a href="/zotonic-license">Apache2 license</a>, which gives you the possibility to use it and modify it in every circumstance.</p>

        {% with m.rsc['page_gallery'].id as id %}
        <h2><a href="{{ m.rsc[id].page_url }}">{{ m.rsc[id].short_title }} &raquo;</a></h2>
        <p>
            <a href="{{ m.rsc[id].page_url }}">{% image m.rsc[id].o.haspart|first width=320 %}</a>
        </p>
        {% endwith %}

        {% with m.rsc['zotonic_sites'].id as id %}
            {% with m.rsc[id].o.haspart|first as spotlight %}
                {% if spotlight %}
                    <h2><a href="{{ m.rsc[id].page_url }}">{{ m.rsc[id].short_title }} &raquo;</a></h2>
                    <p><a href="{{ m.rsc[id].page_url }}">{% image m.rsc[id].o.haspart|first width=320 %}</a></p>
                {% else %}
                    <h2>{{ m.rsc[id].short_title }} &raquo;</h2>
                    <h3>Coming Soon!</h3>
                {% endif %}
                </p>
            {% endwith %}
        {% endwith %}
	</aside>

{% endblock %}


{% block post %}
    <a href="https://github.com/zotonic/zotonic"><img style="position: absolute; top: 0; right: 0; border: 0;" src="https://camo.githubusercontent.com/38ef81f8aca64bb9a64448d0d70f1308ef5341ab/68747470733a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f6461726b626c75655f3132313632312e706e67" alt="Fork me on GitHub" data-canonical-src="https://s3.amazonaws.com/github/ribbons/forkme_right_darkblue_121621.png"></a>
{% endblock %}
