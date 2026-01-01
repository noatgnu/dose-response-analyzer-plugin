# Dose-Response Analysis

**ID**: `dose-response`  
**Version**: 1.0.0  
**Category**: analysis  
**Author**: CauldronGO Team

## Description

Fit dose-response curves and calculate IC50 values for compound screening data

## Runtime

- **Type**: `python`
- **Script**: `dose_response_analyzer.py`

## Inputs

| Name | Label | Type | Required | Default | Visibility |
|------|-------|------|----------|---------|------------|
| `input_file` | Input Data File | file | Yes | - | Always visible |
| `compound_col` | Compound Column | text | No | Compound | Always visible |
| `concentration_col` | Concentration Column | text | No | Conc | Always visible |
| `response_col` | Response Column | text | No | Rab10 | Always visible |
| `enable_custom_models` | Enable Custom Models | boolean | No | true | Always visible |
| `selection_metric` | Model Selection Metric | select (rmse, aic, bic, r2) | No | rmse | Always visible |
| `show_ic50_lines` | Show IC50 Lines | boolean | No | true | Always visible |
| `show_dmax_lines` | Show Dmax Lines | boolean | No | true | Always visible |
| `file_format` | Output Format | select (svg, png, pdf) | No | svg | Always visible |
| `add_timestamp` | Add Timestamp | boolean | No | true | Always visible |
| `create_overlay` | Create Overlay Plot | boolean | No | false | Always visible |
| `overlay_compounds` | Overlay Compounds | text | No | - | Visible when `create_overlay` = `true` |
| `compound_colors` | Compound Colors | text | No | - | Visible when `create_overlay` = `true` |

### Input Details

#### Input Data File (`input_file`)

Data file containing compound, concentration, and response values


#### Compound Column (`compound_col`)

Column name for compound identifiers


#### Concentration Column (`concentration_col`)

Column name for concentration values


#### Response Column (`response_col`)

Column name for response values


#### Enable Custom Models (`enable_custom_models`)

Include extended set of dose-response models


#### Model Selection Metric (`selection_metric`)

Metric used to select the best fitting model

- **Options**: `rmse`, `aic`, `bic`, `r2`

#### Show IC50 Lines (`show_ic50_lines`)

Display IC50 reference lines on plots


#### Show Dmax Lines (`show_dmax_lines`)

Display Dmax reference lines on plots


#### Output Format (`file_format`)

File format for output plots

- **Options**: `svg`, `png`, `pdf`

#### Add Timestamp (`add_timestamp`)

Add timestamp to output filenames


#### Create Overlay Plot (`create_overlay`)

Create a plot with multiple compounds overlaid


#### Overlay Compounds (`overlay_compounds`)

Comma-separated list of compounds to overlay on one plot

- **Placeholder**: `CompoundA,CompoundB,CompoundC`

#### Compound Colors (`compound_colors`)

Semicolon-separated compound:color pairs for overlay plot

- **Placeholder**: `CompoundA:#ff0000;CompoundB:#00ff00`

## Outputs

| Name | File | Type | Format | Description |
|------|------|------|--------|-------------|
| `summary_table` | `summary_table.txt` | data | tsv | Summary statistics for all fitted models |
| `best_models` | `best_models.txt` | data | tsv | Best fitting model parameters and IC50 values for each compound |
| `dose_response_plots` | `dose_response*.svg` | image | svg | Individual dose-response curve plots for each compound |
| `overlay_plot` | `overlay*.svg` | image | svg | Overlay plot with multiple compounds (if overlay_compounds specified) |

## Requirements

- **Python**: >=3.11
- **Packages**:
  - pandas>=2.0.0
  - numpy>=1.24.0
  - matplotlib>=3.7.0
  - dra>=0.1.0

## Example Data

This plugin includes example data for testing:

```yaml
  file_format: svg
  create_overlay: false
  input_file: dose_response/example_data.csv
  concentration_col: Conc
  response_col: Rab10
  show_ic50_lines: true
  show_dmax_lines: true
  compound_col: Compound
  enable_custom_models: true
  selection_metric: rmse
```

Load example data by clicking the **Load Example** button in the UI.

## Usage

### Via UI

1. Navigate to **analysis** → **Dose-Response Analysis**
2. Fill in the required inputs
3. Click **Run Analysis**

### Via Plugin System

```typescript
const jobId = await pluginService.executePlugin('dose-response', {
  // Add parameters here
});
```
