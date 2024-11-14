{% macro extract_color(description) %}
    {% set colors = [
        'RED', "'BLUE'", 'GREEN', 'YELLOW', 'ORANGE', 'PURPLE', 'PINK', 'BLACK', 'WHITE', 'BROWN', 'GREY', 'SILVER', 
        'GOLD', 'BEIGE', 'CHOCOLATE', 'VIOLET', 'MAGENTA', 'CYAN', 'TURQUOISE', 'LIME', 'TEAL', 'AQUA', 'PEACH', 
        'LAVENDER', 'IVORY', 'MAROON', 'CORAL', 'NAVY', 'INDIGO', 'MINT', 'SALMON', 'FUCHSIA', 'OCHRE', 'TAN', 
        'PLUM', 'OLIVE', 'PEARL', 'MAUVE', 'CRIMSON', 'CHARTREUSE', 'JADE', 'COBALT', 'RUBY', 'SAPPHIRE', 
        'EMERALD', 'AMBER', 'CARAMEL', 'BRONZE', 'BURGUNDY', 'PERIWINKLE', 'AMETHYST', 'CHARCOAL'
    ] %}

    {% set description_cleaned = description | upper | replace("'", "") | trim %}

    {% set found_color = "'-'" %}

    {% for color in colors %}
        {% if color in description_cleaned %}
            {% set found_color = color %}
            {% break %}
        {% endif %}
    {% endfor %}

    {{ found_color }}
{% endmacro %}