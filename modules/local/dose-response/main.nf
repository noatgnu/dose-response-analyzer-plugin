process DOSE_RESPONSE {
    label 'process_medium'

    container "${ workflow.containerEngine == 'singularity' ?
        'docker://cauldron/dose-response:1.0.1' :
        'cauldron/dose-response:1.0.1' }"

    input:
    path input_file
    val compound_col
    val concentration_col
    val response_col
    val enable_custom_models
    val selection_metric
    val show_ic50_lines
    val show_dmax_lines
    val file_format
    val add_timestamp
    val create_overlay
    val overlay_compounds
    val compound_colors

    output:
    
    path "summary_table.txt", emit: summary_table, optional: true
    path "best_models.txt", emit: best_models, optional: true
    path "dose_response*.svg", emit: dose_response_plots, optional: true
    path "overlay*.svg", emit: overlay_plot, optional: true
    path "versions.yml", emit: versions

    script:
    def args = task.ext.args ?: ''
    """
    # Build arguments dynamically to match CauldronGO PluginExecutor logic
    ARG_LIST=()

    
    # Mapping for file_format
    VAL="$file_format"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--file_format" "\$VAL")
    fi
    
    # Mapping for add_timestamp
    VAL="$add_timestamp"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        if [ "\$VAL" = "true" ]; then
            ARG_LIST+=("--add_timestamp")
        fi
    fi
    
    # Mapping for compound_colors
    VAL="$compound_colors"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--compound_colors" "\$VAL")
    fi
    
    # Mapping for input_file
    VAL="$input_file"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--input_file" "\$VAL")
    fi
    
    # Mapping for response_col
    VAL="$response_col"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--response_col" "\$VAL")
    fi
    
    # Mapping for show_dmax_lines
    VAL="$show_dmax_lines"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        if [ "\$VAL" = "true" ]; then
            ARG_LIST+=("--show_dmax_lines")
        fi
    fi
    
    # Mapping for overlay_compounds
    VAL="$overlay_compounds"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--overlay_compounds" "\$VAL")
    fi
    
    # Mapping for compound_col
    VAL="$compound_col"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--compound_col" "\$VAL")
    fi
    
    # Mapping for concentration_col
    VAL="$concentration_col"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--concentration_col" "\$VAL")
    fi
    
    # Mapping for enable_custom_models
    VAL="$enable_custom_models"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        if [ "\$VAL" = "true" ]; then
            ARG_LIST+=("--enable_custom_models")
        fi
    fi
    
    # Mapping for selection_metric
    VAL="$selection_metric"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        ARG_LIST+=("--selection_metric" "\$VAL")
    fi
    
    # Mapping for show_ic50_lines
    VAL="$show_ic50_lines"
    if [ -n "\$VAL" ] && [ "\$VAL" != "null" ] && [ "\$VAL" != "[]" ]; then
        if [ "\$VAL" = "true" ]; then
            ARG_LIST+=("--show_ic50_lines")
        fi
    fi
    
    python /app/dose_response_analyzer.py \
        "\${ARG_LIST[@]}" \
        --output_folder . \
        \${args:-}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        Dose-Response Analysis: 1.0.1
    END_VERSIONS
    """
}
