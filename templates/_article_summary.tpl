<div class="blogitem">
    <h2><a href="{{ m.rsc[id].page_url }}">{{ m.rsc[id].title }}</a></h2>
    {% include "_blog_meta.tpl" %}
    {% if id.media %}{% image id width=540 height=340 %}{% endif %}
    <p>
        {{ id.summary }}
        <a href="{{ id.page_url }}">Read more &raquo;</a>
    </p>
</div>
