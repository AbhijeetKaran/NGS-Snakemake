
#showing error after running all the files: ERROR files missing

if config['preprocess']['qc'] == True:
    if config['preprocess_tools']['qc'] == "fastqc":
        rule all_qc:
            input:
                sample=expand(config['output']['baseFolder']+"/fastqc/{samples}_{R}.fastqc.{extension}",samples=['CIB6284','CIB3152','CIB3153'],R=['R1','R2'],extension=['zip','html'])

        rule fastqc:
            input:
                sample=expand(config['input']['baseFolder']+"/{sample}/{sample}_{read}.fastq",sample=['CIB6284','CIB3152','CIB3153'],read=['R1','R2']),
            output:
                zip=config['output']['baseFolder']+"/fastqc/{sample}_{read}.fastqc.zip",
                html=config['output']['baseFolder']+"/fastqc/{sample}_{read}.fastqc.html"
            threads:
                config['preprocess_tools']['threads']
            params:
                path=config['output']['baseFolder']+"/fastqc"
            shell:
                '''
                    fastqc {input.sample} --threads {threads} -o {params.path} 
                '''