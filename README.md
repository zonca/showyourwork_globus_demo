# Snakemake Globus Demo

Example of using Globus with Snakemake via `globus-cli`.

Snakemake has support for GridFTP, but the newest Globus server v5 has no
support for GridFTP, if my understanding is correct.

We assume to run on a machine that has a Globus endpoint attached, like a Supercomputer.
We also assume the user already ran `globus login` to authenticate.

The Snakefile script:

* Downloads data from Globus to local filesystem
* Does local processing
* Uploads the results to Globus (for testing we are using the same endpoint, but it would be more meaningful with a third shared endpoint)

## Configuration

The most common use-case of Globus with ShowYourWork is probably to download a
large dataset to your local cluster so you can do some processing on it.  If
you want to share this workflow with other users, the remote endpoint will
be the same for everyone, but the local endpoint will be the one on your
cluster.  To support this, there is a configuration file where these options
can be configured:

```yaml
DEST_ENDPOINT: 
    UUID: c3dc2ae2-74c6-11e8-93bb-0a6d4e044368
    remote_dir: /~/showyourwork/showyourwork_globus_demo/
    local_dir: /mnt/home/lgarrison/showyourwork/showyourwork_globus_demo
```

See examples in the `config` folder, and select a config file with:

```console
$ snakemake -c1 --configfile=config/myconfigfile.yaml
```


The `UUID` should be set to your endpoint's UUID.  The `remote_dir` is the
path to the download directory *as seen by the endpoint*; the `local_dir`
should be the same directory as seen by Snakemake.
