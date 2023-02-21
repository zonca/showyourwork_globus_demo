Snakemake Globus Demo
=====================

Example of using Globus with Snakemake via `globus-cli`.

Snakemake has support for GridFTP, but the newest Globus server v5 has no
support for GridFTP, if my understanding is correct.

We assume to run on a machine that has a Globus endpoint attached, like a Supercomputer.
We also assume the user already ran `globus login` to authenticate.

The Snakefile script:

* Downloads data from Globus to local filesystem
* Does local processing
* Uploads the results to Globus (for testing we are using the same endpoint, but it would be more meaningful with a third shared endpoint)
