configfile: "config.yaml"

from pathlib import Path

SOURCE_ENDPOINT = config['endpoints']['SOURCE_ENDPOINT']['UUID']

rule upload_results:
    input:
        "data/output_abacus.par"
    run:
        uuid = config['endpoints']['DEST_ENDPOINT']['UUID']
        infn = Path(config['endpoints']['DEST_ENDPOINT']['remote_dir']) / 'data/output_abacus.par'
        outfn = Path(config['endpoints']['DEST_ENDPOINT']['remote_dir']) / 'results/output_abacus.par'
        shell("globus transfer {uuid}:{infn} {uuid}:{outfn}")

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
    run:
        import time
        dst_uuid = config['endpoints']['DEST_ENDPOINT']['UUID']
        dst_fn = Path(config['endpoints']['DEST_ENDPOINT']['remote_dir']) / "data/abacus.par"
        shell("globus transfer {SOURCE_ENDPOINT}:/~/AbacusSummit_base_c000_ph000/abacus.par {dst_uuid}:{dst_fn}")
        while not Path(output[0]).exists():
            time.sleep(0.5)
