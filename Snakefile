SOURCE_ENDPOINT = "ffc65d7a-0bf9-11ec-90b4-41052087bc27"
DEST_ENDPOINT = "9d6d994a-6d04-11e5-ba46-22000b92c6ec"

rule upload_results:
    input:
        "data/output_abacus.par"
    shell:
        "globus transfer {DEST_ENDPOINT}:/~/p/software/showyourwork_globus_demo/data/output_abacus.par {DEST_ENDPOINT}:/~/p/software/showyourwork_globus_demo/results/output_abacus.par"

rule process_data:
    input:
        "data/abacus.par"
    output:
        "data/output_abacus.par"
    run:
        with open(input[0], "r") as in_file:
            with open(output[0], "w") as out_file:
                out_file.write(in_file.read())

rule copy_data:
    output:
        "data/abacus.par"
    shell:
        "globus transfer {SOURCE_ENDPOINT}:/~/AbacusSummit_base_c000_ph000/abacus.par {DEST_ENDPOINT}:/~/p/software/showyourwork_globus_demo/data/abacus.par"
