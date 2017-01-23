%Test of Extraction Process
cppi_init;
config.subjects = [config.subjects(2)];  
tools = cppi_batch_subjects(config,payload,'sub0012');
cd('/home/noah/Development/cppi');
[betas,sem] = tools.extract_roi_beta_comparison('Primary Motor Cortex (lh)','Primary Somatosensory Cortex (lh)','Hand Knob (lh)');
cppi_comparison_graph(betas,sem);
disp('function has completed');