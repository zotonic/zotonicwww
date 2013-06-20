        <div>
            <a href="#" id="toggle_btn">Show 2 columns</a>
            {% wire id="toggle_btn" text="Show as List" action={update target="panel" template="_zotonic_sites_2_col.tpl" id=id} %}
        </div>
        <section>
        {% for c_id in m.rsc[id].o.haspart %}
                {% if c_id %}
                        <div class="zp-100" style="margin-bottom: 30px;">
                                <section class="zp-50 padding">
                                        {% if m.rsc[c_id].summary %}
                                                <p class="summary">{{ m.rsc[c_id].summary }}</p>
                                        {% endif %}
                                        {% if m.rsc[c_id].depiction %}
                                                <a href="{% image_url c_id.depiction width=960 lossless %}"
                                                          title="{{ c_id.title }}" rel="lightbox[gallery-{{c_id}}]">
                                                   {% image c_id.depiction mediaclass="spotlight1" class="spotlight"%}
                                                </a>
                                                {% for img in m.rsc[c_id].media|tail %}
                                                        <div style="display: none">
                                                           <a href="{% image_url img width=960 lossless %}" 
                                                                    title="{{ c_id.title }}" rel="lightbox[gallery-{{c_id}}]">
                                                           </a>
                                                        </div>
                                                        {% endfor %}
                                                {% endif %}
                                </section>
                                <section class="zp-50">
                                        <h2 class="pad_left_20"><a href="{{c_id.website}}" target="new_{{ c_id.id}}">{{ c_id.title }}</a></h2>
                                        <div class="pad_left_20 condensed">
                                            <p><a href="{{ c_id.website }}" target="new_{{c_id.id}}">{{ c_id.website }}</a></p>
                                            {{ c_id.body }}
					    <p>Tags:
					    {% for kw in c_id.o.subject %}
					       <span class="label label-info">{{ kw.title }}</span>
					    {% endfor %}
 					    </p>
					</div>
                                </section>
                        </div>
<hr>
                {% endif %}
        {% endfor %}
        </section>

