# Dose-Response Analysis


## Installation

**[⬇️ Click here to install in Cauldron](http://localhost:50060/install?repo=https%3A%2F%2Fgithub.com%2Fnoatgnu%2Fdose-response-analyzer)** _(requires Cauldron to be running)_

> **Repository**: `https://github.com/noatgnu/dose-response-analyzer`

**Manual installation:**

1. Open Cauldron
2. Go to **Plugins** → **Install from Repository**
3. Paste: `https://github.com/noatgnu/dose-response-analyzer`
4. Click **Install**

**ID**: `dose-response`  
**Version**: 1.0.1  
**Category**: analysis  
**Author**: CauldronGO Team

## Description

Fit dose-response curves and calculate IC50 values for compound screening data

## Runtime

- **Environments**: `python`

- **Entrypoint**: `dose_response_analyzer.py`

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

- **Python Version**: >=3.11

### Python Dependencies (External File)

Dependencies are defined in: `requirements.txt`

- `click`
- `numpy>=1.24.0`
- `pandas>=2.0.0`
- `matplotlib>=3.7.0`
- `dose-response-analyzer>=0.1.0`

> **Note**: When you create a custom environment for this plugin, these dependencies will be automatically installed.

## Example Data

This plugin includes example data for testing:

```yaml
  show_dmax_lines: true
  file_format: svg
  create_overlay: false
  compound_col: Compound
  concentration_col: Conc
  enable_custom_models: true
  selection_metric: rmse
  input_file: dose_response/example_data.csv
  response_col: Rab10
  show_ic50_lines: true
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
