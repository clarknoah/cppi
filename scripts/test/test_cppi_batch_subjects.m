%Test of Extraction Process
%init;
%config.subjects = [config.subjects(1)];  
tools = cppi_batch_subjects(config,payload);
cd('/home/noah/Development/cppi');
[betas,sem] = tools.extract_roi_beta_comparison('Primary Motor Cortex (lh)','Primary Somatosensory Cortex (lh)','Hand Knob (lh)');
cppi_comparison_graph(betas,sem);