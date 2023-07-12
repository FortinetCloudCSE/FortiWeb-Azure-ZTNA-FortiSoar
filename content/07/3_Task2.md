### Jinja2 Filter and Functions

Fortinet provides a very comprehensive Guide which describes all Jinja2 Filters and functions in detail: [FortiSOAR Jinja2 Filter & Functions](https://docs.fortinet.com/document/fortisoar/7.4.1/playbooks-guide/767891/jinja-filters-and-functions#Jinja_Filters_and_Functions)

- access variable `example`

```shell
{{ vars.example }}
```

- access Step variable (List) output

```shell
{{ vars.example[0].value1 }}
```

- `For` loop

```shell
{% for item in vars.example %} 
	{% if item == 'TEST' %}
	Yes  {% endif %}
{% endfor %}
```

- `If` condition

```shell
{% if 1485561600000 > 1484092800000 %}
        {{vars.input.records[0]}} 
            {% elif 5==6 %}
        {{vars.input.records[0]}} 
{% endif %}
```

- `ipaddress` Filter

```shell
{{ test_list | ipaddr }}
```


