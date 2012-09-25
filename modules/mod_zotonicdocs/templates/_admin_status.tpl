{% if m.acl.use.mod_zotonicdocs %}
<div class="control-group">
    <div class="controls">
        {% button class="btn" text=_"Make Zotonic HTML docs" postback=`make` delegate='mod_zotonicdocs' %} 
        <span class="help-inline">{_ Pull and rebuild the Zotonic HTML documentation. _}</span>
    </div>
</div>
{% endif %}
