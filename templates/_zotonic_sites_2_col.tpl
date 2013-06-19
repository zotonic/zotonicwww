        <article id="content">
                <div class="padding">
                        <h1>{{ m.rsc[id].title }}</h1>
                        {% if m.rsc[id].summary %}<p class="summary">{{ m.rsc[id].summary }}</p>{% endif %}
                        {{ m.rsc[id].body }}
                        <a href="#" id="toggle_btn">Show as list</a>
			{% wire id="toggle_btn" text="Show as List" action={update target="panel" template="_zotonic_sites_1_col.tpl" id=id} %}
                </div>
        </article>

        <section>
        {% for c_ids in m.rsc[id].o.haspart|split_in:2 %}
		<section class="zp-50">
			{% for c_id in c_ids %}
				{% if c_id %}
                                        {% if m.rsc[c_id].summary %}
                                                <p class="summary">{{ m.rsc[c_id].summary }}</p>
                                        {% endif %}
                                        {% if m.rsc[c_id].depiction %}
					<h2><a href="{{c_id.website}}" target="new_{{ c_id.id}}">{{ c_id.title }}</a></h2>
                                        <div>
                                                <a href="{% image_url c_id.depiction width=960 lossless %}" 
                                                            title="{{ c_id.title }}" rel="lightbox[gallery-{{c_id}}]">
                                                            {% image c_id.depiction mediaclass="spotlight2" class="spotlight" %}
                                                </a>
					</div>
                                              {% for img in m.rsc[c_id].media|tail %}
                                                   <div style="display: none">
                                                         <a href="{% image_url img width=960 lossless %}" 
                                                                     title="{{ c_id.title }}" rel="lightbox[gallery-{{c_id}}]">
                                                         </a>
                                                   </div>
                                              {% endfor %}
                                        {% endif %}
                                        <div class="condensed" id="spotlight" style="margin-bottom: 60px;padding-top: 5px;">
                                            <p><a href="{{ c_id.website }}" target="new_{{c_id.id}}">{{ c_id.website }}</a></p>
                                            {{ c_id.body }}
                                            <p>Tags:
                                            {% for kw in c_id.o.subject %}
                                                <span class="label label-info">{{ kw.title }}</span>
                                            {% endfor %}
                                            </p>
					</div>
                		{% endif %}
        		{% endfor %}
		</section>
        {% endfor %}
        </section>

