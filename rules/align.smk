
#find a way for creating index files
#find a way to first check index and then use otherwise create and then run
#change params and structure for 'bowtie' and 'star'

if config['alignment']['align'] == True:
    rule all_align:
        input:
            bam=expand(config['output']['baseFolder']+"/bam/{bams}.bam",bams=['CIB6284','CIB3152','CIB3153'])

    if config['alignment_tools']['aligner'] == 'hisat2':
        rule hisat_align:
            input: 
                read1=config['input']['baseFolder']+"/{sample}/{sample}_R1.fastq",
                read2=config['input']['baseFolder']+"/{sample}/{sample}_R2.fastq"
            output:
                sam=config['output']['baseFolder']+"/bam/{sample}.sam",
                bam=config['output']['baseFolder']+"/bam/{sample}.bam"
            threads:
                config['alignment_tools']['threads']
            params:
                ref=config['alignment_tools']['refPrefix']
            shell:
                ''' hisat2 -p {threads} -x {params.ref} -1 {input.read1} -2 {input.read2} -S {output.sam}
                    samtools view -@ {threads} -bS {output.sam} | samtools sort -@ {threads} > {output.bam}
                    samtools index {output.bam}
                '''
    
    elif config['alignment_tools']['aligner'] == 'bwa':
        rule bwa_align:
            input: 
                read1=config['input']['baseFolder']+"/{sample}/{sample}_R1.fastq",
                read2=config['input']['baseFolder']+"/{sample}/{sample}_R2.fastq"
            output:
                sam=config['output']['baseFolder']+"/bam/{sample}.sam",
                bam=config['output']['baseFolder']+"/bam/{sample}.bam"
            threads:
                config['alignment_tools']['threads']
            params:
                ref=config['alignment_tools']['refPrefix']
            shell:
                ''' bwa mem {params.ref} {input.read1} {input.read2} > {output.sam}
                    samtools view -@ {threads} -bS {output.sam} | samtools sort -@ {threads} > {output.bam}
                    samtools index {output.bam}
                '''
    
    elif config['alignment_tools']['aligner'] == 'bowtie':
        rule bwa_align:
            input: 
                read1=config['input']['baseFolder']+"/{sample}/{sample}_R1.fastq",
                read2=config['input']['baseFolder']+"/{sample}/{sample}_R2.fastq"
            output:
                sam=config['output']['baseFolder']+"/bam/{sample}.sam",
                bam=config['output']['baseFolder']+"/bam/{sample}.bam"
            threads:
                config['alignment_tools']['threads']
            params:
                ref=config['alignment_tools']['refPrefix']
            shell:
                ''' bwa mem {params.ref} {input.read1} {input.read2} > {output.sam}
                    samtools view -@ {threads} -bS {output.sam} | samtools sort -@ {threads} > {output.bam}
                    samtools index {output.bam}
                '''

    elif config['alignment_tools']['aligner'] == 'star':
        rule bwa_align:
            input: 
                read1=config['input']['baseFolder']+"/{sample}/{sample}_R1.fastq",
                read2=config['input']['baseFolder']+"/{sample}/{sample}_R2.fastq"
            output:
                sam=config['output']['baseFolder']+"/bam/{sample}.sam",
                bam=config['output']['baseFolder']+"/bam/{sample}.bam"
            threads:
                config['alignment_tools']['threads']
            params:
                ref=config['alignment_tools']['refPrefix']
            shell:
                ''' bwa mem {params.ref} {input.read1} {input.read2} > {output.sam}
                    samtools view -@ {threads} -bS {output.sam} | samtools sort -@ {threads} > {output.bam}
                    samtools index {output.bam}
                '''


