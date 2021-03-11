multibranchPipelineJob('${folder_name}/${repository_name}-pipeline') {
    branchSources {
        github {
            id = '${repository_name}'
            repoOwner = '${repository_owner}'
            repository = '${repository_name}'

            checkoutCredentialsId = '${git_credential_id}'
            scanCredentialsId = '${git_credential_id}'

            buildForkPRHead(false)
            buildForkPRMerge(false)
            buildOriginBranch()
        }
    }

    displayName('${pipeline_display_name}')

    orphanedItemStrategy {
        discardOldItems {
            daysToKeep(4)
            numToKeep(18)
        }
    }
}
