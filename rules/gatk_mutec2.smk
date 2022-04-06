if config['variant_calling']== True:
    rule all_gatk:
        input:
            vcf=expand(config['output']['baseFolder']+"/vcf/{vcfs}.vcf",vcfs=['CIB6284','CIB3152','CIB3153'])

    if config['varint_calling_tools']['vcaller'] == 'gatk-mutec2':
        rule gatk_mutec_caller:
            input: 
                bam=config['output']['baseFolder']+"/bam/{sample}.bam",
            output:
                mrkbam=config['output']['baseFolder']+"/bam/{sample}_mrk.bam",
                mrkmat=config['output']['baseFolder']+"/bam/{sample}_mrk.txt",
                gpbam=config['output']['baseFolder']+"/bam/{sample}_grp.bam",
                gpsortbam=config['output']['baseFolder']+"/bam/{sample}_grpsort.bam",
                vcf=config['output']['baseFolder']+"/vcf/{sample}.vcf"
            params:
                ref="../data/ref/covid_ref.fasta"
            threads:
                4
            shell:
                '''
                    picard MarkDuplicates I={input.bam} O={output.mrkbam} M={output.mrkmat}
                    picard AddOrReplaceReadGroups I={output.mrkbam} O={output.gpbam} RGID=1 RGLB=lib_variants RGPL=illumina RGPU=unit1 RGSM=mixReads
                    samtools sort -@ {threads} {output.gpbam} > {output.gpsortbam}
                    samtools index {output.gpsortbam}
                    gatk Mutect2 -I {output.gpsortbam} -O {output.vcf} -R {params.ref}
                '''