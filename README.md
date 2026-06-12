# Measurement Error in Causal Inference

An interactive tutorial on classical measurement error in causal inference,
covering attenuation bias, ME in conditioning variables, and IV/2SLS correction.
View the tutorial at https://londonmae.github.io/measurement-error-tutorial/. 

## Running locally (for development)

### Prerequisites

- [Quarto](https://quarto.org/docs/get-started/) ≥ 1.4
- Python ≥ 3.9
- R ≥ 4.0

### 1. Install Python dependencies

```bash
pip install -r requirements.txt
```

### 2. Install R packages

```r
install.packages(c("wooldridge", "NHANES", "AER"))
```

### 3. Preview with live reload

```bash
quarto preview index.qmd
```

This command opens the tutorial in your browser and automatically re-renders when you save changes to `index.qmd`.

### 4. Render to HTML

```bash
quarto render index.qmd
```

Output is written to `_site/index.html`.

---

## Supplemental R scripts

`scripts.R` and `check_scripts.R` contain the hands-on exercises from the tutorial as executable R cells. Open either file in VS Code with the R extension and run cells with **Ctrl+Enter**.
