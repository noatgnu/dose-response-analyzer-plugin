#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { DOSE_RESPONSE } from './modules/local/dose-response/main'

workflow PIPELINE {
    main:
    DOSE_RESPONSE (
        params.input_file ? Channel.fromPath(params.input_file).collect() : Channel.of([]),
        Channel.value(params.compound_col ?: ''),
        Channel.value(params.concentration_col ?: ''),
        Channel.value(params.response_col ?: ''),
        Channel.value(params.enable_custom_models ?: ''),
        Channel.value(params.selection_metric ?: ''),
        Channel.value(params.show_ic50_lines ?: ''),
        Channel.value(params.show_dmax_lines ?: ''),
        Channel.value(params.file_format ?: ''),
        Channel.value(params.add_timestamp ?: ''),
        Channel.value(params.create_overlay ?: ''),
        Channel.value(params.overlay_compounds ?: ''),
        Channel.value(params.compound_colors ?: ''),
    )
}

workflow {
    PIPELINE ()
}
